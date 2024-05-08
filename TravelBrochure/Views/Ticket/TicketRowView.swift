import SwiftUI
import SwiftyToys

struct TicketRowView: View {
    @Binding var project: Project
    @Binding var ticket: Ticket
    @State var checked: Bool
    @State var showEditSheet = false
    
    init(_ project: Binding<Project>, _ ticket: Binding<Ticket>) {
        if let projectIndex = ticket.wrappedValue.projectIndex(project.id) {
            self.checked = ticket.wrappedValue.projects[projectIndex].checked
        } else {
            self.checked = false
        }

        self._project = project
        self._ticket = ticket
    }

    var body: some View {
        HStack {
            checkbox()
            title()
                .onTapGesture {
                    self.showEditSheet = true
                }
            
        }
        .sheet(isPresented: $showEditSheet) {
            TicketEditView(project: $project, ticket: $ticket)
                .presentationDetents([.medium, .large])
        }
    }
    
    private func checkbox() -> some View {
        Toggle(isOn: $checked) { }
        .toggleStyle(.checkBox)
        .labelsHidden()
        .onChange(of: checked) {
            if let projectIndex = ticket.projectIndex(project.id) {
                ticket.projects[projectIndex].checked = checked
                return
            }
            ticket.projects.append(.init(id: project.id, checked: checked))
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

