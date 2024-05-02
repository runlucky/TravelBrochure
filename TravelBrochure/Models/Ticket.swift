import Foundation

struct Ticket: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var rank: Int
    var memo: String
    var tag: String
    
    var projects: [Project] = []
    
    init(name: String, rank: Int, memo: String, tag: String) {
        self.name = name
        self.rank = rank
        self.memo = memo
        self.tag = tag
    }
    
    struct Project: Codable {
        var id: String
        var checked: Bool
    }
}
