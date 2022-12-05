import SwiftUI

struct FocusStateWithModifier: View {
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
            
            // Change the argument to use `model.focus` and the bind fails
            OneWayFocusPrinter(focus: focus)
            // Displaying both model and view focus values also works correctly
//            FocusPrinter(model: model.focus, view: focus)
        }
        .frame(maxWidth: 200)
        .padding()
        .synchronize($model.focus, to: $focus)
    }
}

private extension View {
    func synchronize<Value: Hashable>(
    _ modelValue: Binding<Value>,
    to viewValue: FocusState<Value>.Binding
  ) -> some View {
    self.modifier(_Bind(modelValue: modelValue, viewValue: viewValue))
  }
}

private struct _Bind<Value: Hashable>: ViewModifier {
    let modelValue: Binding<Value>
    let viewValue: FocusState<Value>.Binding
    
    @State var hasAppeared = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !self.hasAppeared else { return }
                self.hasAppeared = true
                guard self.viewValue.wrappedValue != self.modelValue.wrappedValue else { return }
                self.viewValue.wrappedValue = self.modelValue.wrappedValue
            }
            .onChange(of: self.modelValue.wrappedValue) {
                guard self.viewValue.wrappedValue != $0
                else { return }
                self.viewValue.wrappedValue = $0
            }
            .onChange(of: self.viewValue.wrappedValue) {
                guard self.modelValue.wrappedValue != $0
                else { return }
                self.modelValue.wrappedValue = $0
            }
    }
}
