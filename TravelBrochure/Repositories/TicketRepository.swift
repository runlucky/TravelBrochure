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
}

/// CRUD
extension TicketRepository {
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
    
    func upsert(_ ticket: Ticket) {
        if let index = tickets.firstIndex(where: { $0.id == ticket.id }) {
            tickets[index] = ticket
        } else {
            tickets.append(ticket)
        }
    }
}

extension TicketRepository {
    func ticketIndex(_ ticketID: String) -> Int? {
        tickets.firstIndex { $0.id == ticketID }
    }
    
    func getTicket(_ ticketID: String) -> Binding<Ticket>? {
        guard let index = self.tickets.firstIndex(where: { $0.id == ticketID }) else { return nil }
        
//        let xxx = self.tickets[index]
        
        fatalError()

    }
}
