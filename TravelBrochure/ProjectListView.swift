import Foundation
import SwiftUI
import SwiftyToys

struct ProjectListView: View {
    @StateObject private var repository = ProjectRepository.shared
    @State private var selectedProject: Binding<Project>? = nil

    init() {
    }
    
    var body: some View {
        List {
            Button("add project") {
                let project = Project(name: "my project \(repository.projects.count + 1)")
                repository.add(project)
            }
            ForEach($repository.projects) { project in
                showProjectName(project)
            }
        }
        .sheet(item: $selectedProject) { project in
            ProjectView(project: project)
        }
        
    }
    
    func showProjectName(_ project: Binding<Project>) -> some View {
        Text(project.name.wrappedValue)
            .onTapGesture {
                selectedProject = project
            }
    }
    
}

#Preview {
    ProjectListView()
}
