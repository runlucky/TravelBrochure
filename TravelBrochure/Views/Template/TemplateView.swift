import SwiftUI
import SwiftyToys

struct TemplateView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var templateRepository = TemplateRepository.shared
    @StateObject var ticketRepository = TicketRepository.shared
    @Binding var template: Template
    
    @State var isEditMode = false
    
    @State var showAddTicket = false
    
    var body: some View {
        List {
            if isEditMode {
                TextField("テンプレート名", text: $template.name)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Image(systemName: "text.justify.left")
                        .foregroundStyle(Color.text.opacity(0.5))
                    TextField("メモ...", text: $template.memo, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                }

            } else {
                Text(template.name)
                HStack {
                    Image(systemName: "text.justify.left")
                        .foregroundStyle(Color.text.opacity(0.5))
                    Text(template.memo)
                }

            }
             

            let tickets = template.ticketIDs.compactMap { ticketRepository.getTicket($0) }
            
            let tags = tickets.map { $0.wrappedValue.tag }
                .uniqued()
                .sorted()

            ForEach(tags, id: \.self) { tag in
                Section(tag) {
                    let filteredTickets = tickets.filter { $0.wrappedValue.tag == tag }
                    ForEach(filteredTickets, id: \.id) { ticket in
                        Text(ticket.name.wrappedValue)
//                        TicketRowView($project, ticket)
                    }
                }
            }
            
            if isEditMode {
                Section {
                    Button("チケットを追加") {
                        showAddTicket = true
                    }
                }
                
                Section {
                    Button("このテンプレートを削除", role: .destructive) {
                        templateRepository.delete(template)
                        dismiss()
                    }
                }
                
            } else {
                Section {
                    Button("このテンプレートで開始する") {
                        
                        dismiss()
                    }
                }
            }


        }
        .navigationTitle("テンプレートの選択")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if isEditMode {
                    Button("完了") {
                        isEditMode = false
                    }
                } else {
                    Button("編集") {
                        isEditMode = true
                    }
                }
            }
//            ToolbarItem(placement: .primaryAction) {
//                Button("追加") {
//                    //                        ticketRepository.upsert(ticket)
//                    //                        project.ticketIDs.append(ticket.id)
//                    //                        dismiss()
//                }.disabled(template.name.isEmpty)
//            }
        }
        .sheet(isPresented: $showAddTicket) {
            TicketAddTemplateView(template: $template)
        }
    }
}

#Preview {
    ProjectView(project: .constant(.init(name: "テストプロジェクト")))
}
