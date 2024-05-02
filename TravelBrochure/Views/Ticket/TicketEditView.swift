import SwiftUI

struct TicketEditView: View {
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
            }
            .listStyle(.grouped)
        }
    }
}

#Preview {
    @State var ticket = Ticket(name: "チケット名", rank: 2, memo: "", tag: "食料")
    return TicketEditView(ticket: $ticket)
}
