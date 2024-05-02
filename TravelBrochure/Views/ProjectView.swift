//
//  ProjectView.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/01.
//

import SwiftUI
import SwiftyToys

struct ProjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var projectRepository = ProjectRepository.shared
    @StateObject var ticketRepository = TicketRepository.shared
    @Binding var project: Project
    
    
    var body: some View {
        List {
            TextField("プロジェクト名", text: $project.name)
            
            Button("add ticket") {
                let ticket = Ticket(name: "my ticket \(ticketRepository.tickets.count + 1)",
                                    rank: 1, memo: "", tag: "")
                
                ticketRepository.upsert(ticket)
                project.ticketIDs.append(ticket.id)
            }
            
            Section("tickets") {
                ForEach(project.ticketIDs, id: \.self) { id in
                    if let index = ticketRepository.tickets.firstIndex(where: { $0.id == id}) {
                        let ticket = $ticketRepository.tickets[index]
                        TicketRowView(ticket: ticket.wrappedValue)
                    }
                }
            }
            
            Section {
                Button("このプロジェクトを削除", role: .destructive) {
                    projectRepository.delete(project)
                    dismiss()
                }
            }
        }
//        .listStyle(.plain)
    }
}

#Preview {
    ProjectView(project: .constant(.init(name: "テストプロジェクト")))
}
