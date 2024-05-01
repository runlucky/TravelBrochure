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



struct Project: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var timestamp: Date
    var memo: String
    
    var ticketIDs: [String]
    var checkedIDs: [String]
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.memo = ""
        self.ticketIDs = []
        self.checkedIDs = []
    }
}


