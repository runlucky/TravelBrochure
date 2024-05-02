import Foundation

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
    
    func isChecked(_ id: String) -> Bool {
        checkedIDs.contains(id)
    }
}


