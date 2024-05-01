//
//  TicketView.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/01.
//

import SwiftUI

struct TicketRowView: View {
    @Binding var ticket: Ticket
    
    var body: some View {
        HStack {
            TextField("チケット名", text: $ticket.name)
        }
    }
}

#Preview {
    let ticket = Ticket(name: "hogehogeチケット", rank: 2, memo: "メモです", tag: "食料")
    return TicketRowView(ticket: .constant(ticket))
}
