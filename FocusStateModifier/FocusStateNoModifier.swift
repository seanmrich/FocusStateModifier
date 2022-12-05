import SwiftUI

struct FocusStateNoModifier: View {
    @ObservedObject var model: Model
    @FocusState private var focus: Model.Focus?
    
    var body: some View {
        VStack {
            TextField("Title", text: $model.title)
                .focused($focus, equals: .title)
            
            Circle()
                .focusable()
                .focused($focus, equals: .circle)
                .frame(height: 50)
            
            Divider()
            
            FocusPrinter(model: model.focus, view: focus)
        }
        .frame(maxWidth: 200)
        .padding()
        .synchronize($model.focus, to: $focus)
    }
}


private extension View {
    func synchronize<Value>(
        _ modelValue: Binding<Value>,
        to viewValue: FocusState<Value>.Binding
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
