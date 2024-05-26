import SwiftUI

/// Templateに対応したチケット追加画面
/// 通常のTicketAddViewと統合したい
struct TicketAddTemplateView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var ticketRepository = TicketRepository.shared
    @Binding var template: Template
    
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
                }
                
                let tickets = ticketRepository.tickets.filter { !template.ticketIDs.contains($0.id) }
                if tickets.hasElement {
                    Section("既存アイテム") {
                        
                        ForEach(tickets) { ticket in
                            Button(ticket.name) {
                                template.ticketIDs.append(ticket.id)
                                dismiss()
                            }
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
                ToolbarItem(placement: .primaryAction) {
                    Button("追加") {
                        ticketRepository.upsert(ticket)
                        template.ticketIDs.append(ticket.id)
                        dismiss()
                    }.disabled(ticket.name.isEmpty)
                }

            }
        }
    }
}

//#Preview {
//    TicketAddView()
//}
