import SwiftUI

struct ContentView: View {
    @StateObject private var focusStateNoModifierModel = Model()
    @StateObject private var focusStateWithModifierModel = Model()
    @StateObject private var bindingWithModifierModel = Model()

    var body: some View {
        TabView {
            FocusStateNoModifier(model: focusStateNoModifierModel)
                .tabItem { Text("FocusState No Modifier") }
            
            FocusStateWithModifier(model: focusStateWithModifierModel)
                .tabItem { Text("FocusState With Modifier") }
            
            BindingWithModifier(model: bindingWithModifierModel)
                .tabItem { Text("Binding With Modifier") }
        }
        .padding()
    }
}
