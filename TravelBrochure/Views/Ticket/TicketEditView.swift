import SwiftUI

struct TicketEditView: View {
    @Binding var ticket: Ticket
    
    var body: some View {
        VStack {
            TextField("チケット名", text: $ticket.name)
                .textFieldStyle(.roundedBorder)
            
            // タグ
            // ★
            // メモ
            TextField("テキストフィールド", text: $ticket.memo, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            TextField("テキストフィールド", text: $ticket.memo, axis: .vertical)
                .textFieldStyle(.roundedBorder)

            
            
            TextField("チケット名", text: $ticket.name)
                .textFieldStyle(.roundedBorder)
            TextField("チケット名", text: $ticket.name)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    @State var ticket = Ticket(name: "チケット名", rank: 2, memo: "メモです", tag: "食料")
    return TicketEditView(ticket: $ticket)
}
