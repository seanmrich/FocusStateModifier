import SwiftUI

struct FocusPrinter: View {
    let modelFocus: Model.Focus?
    let viewFocus: Model.Focus?
    
    init(model: Model.Focus?, view: Model.Focus?) {
        self.modelFocus = model
        self.viewFocus = view
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Model")
                    .font(.title3)
                Text(modelFocus?.displayName ?? "nil")
            }
            VStack {
                Text("View")
                    .font(.title3)
                Text(viewFocus?.displayName ?? "nil")
            }
        }
    }
}
