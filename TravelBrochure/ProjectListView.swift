import Foundation
import SwiftUI
import SwiftyToys

struct ProjectListView: View {
    @StateObject private var repository = ProjectRepository.shared
    @State var selectedIndex: Int? = nil
    

    init() {
    }
    
    var body: some View {
        List {
            Button("add project") {
                let project = Project(name: "my project \(repository.projects.count + 1)")
                repository.add(project)
            }
            ForEach(Array(repository.projects.enumerated()), id: \.element.id) { index, project in
                showProjectName(project)
                    .onTapGesture {
                        self.selectedIndex = index
                    }
            }
        }
        .sheet(item: $selectedIndex) { index in
            ProjectView(project: $repository.projects[index])
        }
        
    }
    
    func showProjectName(_ project: Project) -> some View {
        Text(project.name)
    }
    
}

#Preview {
    ProjectListView()
}
