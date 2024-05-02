import SwiftUI
import SwiftyToys

struct TicketRowView: View {
    @Binding var ticket: Ticket
    @State var checked: Bool
    @State var showEditSheet = false
    
    let onChanged: (Bool) -> Void

    var body: some View {
        HStack {
            Toggle(isOn: $checked) { }
            .toggleStyle(.checkBox)
            .labelsHidden()
            .onChange(of: checked) {
                onChanged(checked)
            }
            
            Text(ticket.name)
                .onTapGesture {
                    self.showEditSheet = true
                }
        }
        .sheet(isPresented: $showEditSheet) {
            TicketEditView(ticket: $ticket)
                .presentationDetents([.medium, .large])
        }
//        Text(ticket.name)
        
    }
}

#Preview {
    @State var ticket = Ticket(name: "テストチケット", rank: 1, memo: "", tag: "")
    return TicketRowView(ticket: $ticket, checked: true) { _ in }
}
