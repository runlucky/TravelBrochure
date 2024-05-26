import Foundation

/// プロジェクトを作るために用いるテンプレート
internal struct Template: Codable, Identifiable {
    internal let id: String
    internal var name: String
    internal var memo: String
    
    /// このテンプレートに紐づくチケットID一覧
    internal var ticketIDs: [String]
    
    internal init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.memo = ""
        self.ticketIDs = []
    }
}


