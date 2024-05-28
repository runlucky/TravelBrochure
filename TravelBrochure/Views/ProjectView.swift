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

            let tickets = project.ticketIDs.compactMap { ticketRepository.getTicket($0) }
            
            let tags = tickets.map { $0.wrappedValue.tag }
                .uniqued()
                .sorted()

            ForEach(tags, id: \.self) { tag in
                Section(tag) {
                    let filteredTickets = tickets.filter { $0.wrappedValue.tag == tag }
                    ForEach(filteredTickets, id: \.id) { ticket in
                        TicketRowView($project, ticket)
                    }
                }
            }
            .listRowInsets(.init(top: 6, leading: 10, bottom: 6, trailing: 10))

            Section {
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
        .environment(\.defaultMinListRowHeight, 0)
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
