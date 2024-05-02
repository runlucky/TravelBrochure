//
//  TicketAddView.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/02.
//

import SwiftUI

struct TicketAddView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var ticketRepository = TicketRepository.shared
    @Binding var project: Project
    
    
    @State var ticket = Ticket(name: "", rank: 0, memo: "", tag: "")

    var body: some View {
        NavigationStack {
            List {
                
                Section("新規アイテム") {
                    TextField("チケット名", text: $ticket.name)
                    StarRating(rate: $ticket.rank)

                    HStack {
                        Image(systemName: "tag")
                            .foregroundStyle(Color.text.opacity(0.5))
                        TextField("タグ", text: $ticket.tag)
                    }
                    
                    HStack {
                        Image(systemName: "text.justify.left")
                            .foregroundStyle(Color.text.opacity(0.5))
                        TextField("メモ...", text: $ticket.memo, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("追加") {
                        ticketRepository.upsert(ticket)
                        project.ticketIDs.append(ticket.id)
                        dismiss()
                    }.disabled(ticket.name.isEmpty)
                }
                
                Section("既存アイテム") {
                    ForEach(ticketRepository.tickets.filter { !project.ticketIDs.contains($0.id) }) { ticket in
                        Button(ticket.name) {
                            project.ticketIDs.append(ticket.id)
                            dismiss()
                        }
                    }
                }
                
            }
            .listStyle(.grouped)
            .navigationTitle("アイテムの追加")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    TicketAddView()
//}
