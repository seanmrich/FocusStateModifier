import SwiftUI

struct ContentView: View {
    @StateObject private var focusStateNoModifierModel = Model()
    @StateObject private var focusStateWithModifierModel = Model()
    @StateObject private var bindingWithModifierModel = Model()
    @State private var tabSelection = TabSelection.focusWithModifier
    
    var body: some View {
        TabView(selection: $tabSelection) {
            FocusStateNoModifier(model: focusStateNoModifierModel)
                .tabItem { Text("FocusState No Modifier") }
                .tag(TabSelection.focusNoModifier)
            
            FocusStateWithModifier(model: focusStateWithModifierModel)
                .tabItem { Text("FocusState With Modifier") }
                .tag(TabSelection.focusWithModifier)

            BindingWithModifier(model: bindingWithModifierModel)
                .tabItem { Text("Binding With Modifier") }
                .tag(TabSelection.bindingWithModifier)
        }
        .padding()
    }
}

enum TabSelection {
    case focusNoModifier
    case focusWithModifier
    case bindingWithModifier
}
