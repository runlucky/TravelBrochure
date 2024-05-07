import SwiftUI

struct TicketEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var project: Project
    @Binding var ticket: Ticket
    var body: some View {
        NavigationStack {
            List {
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
                
                Section {
                    Button("このプロジェクトから削除") {
                        ticket.projects.removeAll { $0.id == project.id }
                        project.ticketIDs.removeAll { $0 == ticket.id }
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
    }
}
