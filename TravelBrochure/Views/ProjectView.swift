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
                ForEach(project.ticketIDs, id: \.self) { ticketID in
                    if let ticketIndex = ticketRepository.ticketIndex(ticketID) {
                        let ticket = $ticketRepository.tickets[ticketIndex]
                        TicketRowView($project, ticket)
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
