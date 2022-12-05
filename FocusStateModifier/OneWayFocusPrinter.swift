import SwiftUI

struct OneWayFocusPrinter: View {
    let focus: Model.Focus?
    
    init(focus: Model.Focus?) {
        self.focus = focus
    }
    
    var body: some View {
        VStack {
            Text("Model")
                .font(.title3)
            Text(focus?.displayName ?? "nil")
        }
    }
}
