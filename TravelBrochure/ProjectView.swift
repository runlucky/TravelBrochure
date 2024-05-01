//
//  ProjectView.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/01.
//

import SwiftUI

struct ProjectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var projectRepository = ProjectRepository.shared
    @StateObject var ticketRepository = TicketRepository.shared
    @Binding var project: Project
    
    
    var body: some View {
        List {
            Text(project.name)
//            Text(project.memo)
            
            Button("add ticket") {
                let ticket = Ticket(name: "my ticket \(ticketRepository.tickets.count + 1)",
                                    rank: 1, memo: "", tag: "")
                
                ticketRepository.upsert(ticket)
                project.ticketIDs.append(ticket.id)
                if let index = projectRepository.projects.firstIndex(where: { $0.id == project.id }) {
                    projectRepository.projects[index].ticketIDs.append(ticket.id)
                }
            }
            
            Button("print ticket count") {
                print(project.ticketIDs.count)
                
                if let index = projectRepository.projects.firstIndex(where: { $0.id == project.id }) {
                    print(projectRepository.projects[index].ticketIDs.count)
                }
            }
            
            Text(project.ticketIDs.count.description)
            
            Section("tickets") {
                Text(project.ticketIDs.count.description)
                ForEach(project.ticketIDs, id: \.self) { id in
                    if let ticket = ticketRepository.get(id: id) {
                        Text(ticket.name)
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
    }
    
    @ViewBuilder private func showTicket(_ id: String) -> some View {
        if let ticket = ticketRepository.get(id: id) {
            Text(ticket.name)
        }
    }
    
    
    
}

#Preview {
    ProjectView(project: .constant(.init(name: "")))
}
