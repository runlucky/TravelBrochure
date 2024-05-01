import Foundation

struct Ticket: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var rank: Rank
    var memo: String
    var tag: String
    
    init(name: String, rank: Rank, memo: String, tag: String) {
        self.name = name
        self.rank = rank
        self.memo = memo
        self.tag = tag
    }
    
    
    enum Rank: Codable {
        case star1
        case star2
        case star3
        case star4
        case star5
    }
}
