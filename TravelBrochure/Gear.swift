import Foundation

struct Ticket: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var rank: Int
    var memo: String
    var tag: String
}



struct Project: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var timestmap: Date
    var memo: String
    
    var tickets: [Ticket]
    var checkedTickets: [Ticket]
}


