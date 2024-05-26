import Foundation

struct Project: Codable, Identifiable {
    let id: String
    var name: String
    var timestamp: Date
    var memo: String
    
    /// プロジェクトに紐づくチケットID一覧
    var ticketIDs: [String]
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.timestamp = Date()
        self.memo = ""
        self.ticketIDs = []
    }
}


