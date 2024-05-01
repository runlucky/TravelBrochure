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
            
            
            
            TextField("チケット名", text: $ticket.name)
                .textFieldStyle(.roundedBorder)
            TextField("チケット名", text: $ticket.name)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    let ticket = Ticket(name: "hogehogeチケット", rank: 2, memo: "メモです", tag: "食料")
    return TicketEditView(ticket: .constant(ticket))
}
