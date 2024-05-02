//
//  TicketRowView.swift
//  TravelBrochure
//
//  Created by kakeru on 2024/05/02.
//

import SwiftUI

struct TicketRowView: View {
    @State var ticket: Ticket
    @State var checked = false
    var body: some View {
        HStack {
            Toggle(isOn: $checked) {
                Text(ticket.name)
            }
        }
//        Text(ticket.name)
    }
}

#Preview {
    TicketRowView(ticket: Ticket(name: "テストチケット", rank: 1, memo: "", tag: ""))
}
