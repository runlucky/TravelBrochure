import Foundation

struct Project: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var timestamp: Date
    var memo: String
    
    /// プロジェクトに紐づくチケットID一覧
    var ticketIDs: [String]
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.memo = ""
        self.ticketIDs = []
    }
}


