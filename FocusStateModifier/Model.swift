import SwiftUI

class Model: ObservableObject {
    @Published var title = ""
    @Published var focus: Focus? = .circle
    
    enum Focus: Hashable {
        case title
        case circle
    }
}

extension Model.Focus {
    var displayName: String {
        switch self {
        case .title: return "title"
        case .circle: return "circle"
        }
    }
}
