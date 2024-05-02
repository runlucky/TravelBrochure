import SwiftUI
import SwiftyToys

struct TicketRowView: View {
    @Binding var ticket: Ticket
    @State var checked: Bool
    @State var showEditSheet = false
    
    let onChanged: (Bool) -> Void

    var body: some View {
        HStack {
            checkbox()
            title()
                .onTapGesture {
                    self.showEditSheet = true
                }
            
        }
        .sheet(isPresented: $showEditSheet) {
            TicketEditView(ticket: $ticket)
                .presentationDetents([.medium, .large])
        }
    }
    
    private func checkbox() -> some View {
        Toggle(isOn: $checked) { }
        .toggleStyle(.checkBox)
        .labelsHidden()
        .onChange(of: checked) {
            onChanged(checked)
        }
    }
    
    @ViewBuilder private func title() -> some View {
        if checked {
            Text(ticket.name)
                .strikethrough()
                .opacity(0.5)
        } else {
            Text(ticket.name)
        }
    }
    
}

#Preview {
    @State var ticket = Ticket(name: "テストチケット", rank: 1, memo: "", tag: "")
    return TicketRowView(ticket: $ticket, checked: true) { _ in }
}
