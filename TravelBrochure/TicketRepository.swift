import Foundation
import SwiftUI
import SwiftyToys

class TicketRepository: ObservableObject {
    private let storage = container.resolve(IStorage.self)
    private let key = StorageKey(file: "TicketRepository.tickets")
    
    @Published var tickets: [Ticket] = []
    
    static let shared = TicketRepository()
    private init() {
        load()
    }
    
    private func load() {
        do {
            let tickets = try storage.get(key, type: [Ticket].self)
            self.tickets = tickets

        } catch {
            print(error)
        }
    }
    
    func save() {
        try? storage.upsert(key, value: tickets)
    }

    //
//    func add(_ project: Project) {
//        projects.append(project)
//    }
    
    func get(id: String) -> Ticket? {
        tickets.first { $0.id == id }
    }
    
    func upsert(_ ticket: Ticket) {
        if let index = tickets.firstIndex(where: { $0.id == ticket.id }) {
            tickets[index] = ticket
        } else {
            tickets.append(ticket)
        }
    }
}
