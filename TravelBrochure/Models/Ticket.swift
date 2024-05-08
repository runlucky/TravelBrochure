import Foundation

struct Ticket: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var rank: Int
    var memo: String
    var tag: String
    
    /// チケットに紐づくプロジェクト情報一覧
    var projects: [ProjectInfo] = []
    
    init(name: String, rank: Int, memo: String, tag: String) {
        self.name = name
        self.rank = rank
        self.memo = memo
        self.tag = tag
    }
    
    struct ProjectInfo: Codable {
        var id: String
        var checked: Bool
    }
    
    func projectIndex(_ projectID: String) -> Int? {
        self.projects.firstIndex { $0.id == projectID }
    }
}
