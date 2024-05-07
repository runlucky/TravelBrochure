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
    
    @State var showAddTicket = false
    
    var body: some View {
        List {
            TextField("プロジェクト名", text: $project.name)
            HStack {
                Image(systemName: "text.justify.left")
                    .foregroundStyle(Color.text.opacity(0.5))
                TextField("メモ...", text: $project.memo, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
            }

            Section() {
                ForEach(project.ticketIDs, id: \.self) { id in
                    if let index = ticketRepository.tickets.firstIndex(where: { $0.id == id}) {
                        let ticket = $ticketRepository.tickets[index]
                        
                        TicketRowView(project: $project, ticket: ticket, checked: project.isChecked(ticket.id)) { checked in
                            if checked {
                                project.checkedIDs.append(ticket.id)
                            } else {
                                project.checkedIDs.removeAll { $0 == ticket.id }
                            }
                        }
                    }
                }
                
                Button("アイテムを追加") {
                    showAddTicket = true
                }
            }
            
            Section {
                Button("このプロジェクトを削除", role: .destructive) {
                    projectRepository.delete(project)
                    dismiss()
                }
            }
        }
        .navigationTitle(project.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(systemName: "ellipsis") {
                    
                }
            }
        }
        .sheet(isPresented: $showAddTicket) {
            TicketAddView(project: $project)
        }
    }
}

#Preview {
    ProjectView(project: .constant(.init(name: "テストプロジェクト")))
}
