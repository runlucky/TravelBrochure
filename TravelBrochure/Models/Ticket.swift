import Foundation

struct Ticket: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var rank: Int
    var memo: String
    var tag: String
    
    init(name: String, rank: Int, memo: String, tag: String) {
        self.name = name
        self.rank = rank
        self.memo = memo
        self.tag = tag
    }
}
