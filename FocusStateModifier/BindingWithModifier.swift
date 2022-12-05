import SwiftUI

struct BindingWithModifier: View {
    @ObservedObject var model: Model
    @State private var focus: Model.Focus?
    
    var body: some View {
        VStack {
            Button("Title") {
                model.focus = .title
            }
            
            Button("Circle") {
                model.focus = .circle
            }
            
            Divider()
            
            FocusPrinter(model: model.focus, view: focus)
        }
        .frame(maxWidth: 200)
        .padding()
        .synchronize($model.focus, to: $focus)
    }
}


private extension View {
    func synchronize<Value: Equatable>(
        _ modelValue: Binding<Value>,
        to viewValue: Binding<Value>
    ) -> some View {
        WithState(initialValue: false) { $hasAppeared in
            self
                .onAppear {
                    guard hasAppeared == false else { return }
                    hasAppeared = true
                    guard viewValue.wrappedValue != modelValue.wrappedValue else { return }
                    viewValue.wrappedValue = modelValue.wrappedValue
                }
                .onChange(of: modelValue.wrappedValue) {
                    guard viewValue.wrappedValue != $0
                    else { return }
                    viewValue.wrappedValue = $0
                }
                .onChange(of: viewValue.wrappedValue) {
                    guard modelValue.wrappedValue != $0
                    else { return }
                    modelValue.wrappedValue = $0
                }
        }
    }
}

