import Foundation
import SwiftUI
import SwiftyToys

struct ProjectListView: View {
    @StateObject private var repository = ProjectRepository.shared
    @State private var showTemplateList = false
    
    var body: some View {
        NavigationStack {
            List {
                Button("プロジェクトを追加") {
                    showTemplateList = true
                }
                
                Button("★[DEBUG]add project") {
                    let project = Project(name: "my project \(repository.projects.count + 1)")
                    repository.add(project)
                }
                
                Section {
                    ForEach(Array(repository.projects.enumerated()), id: \.element.id) { index, project in
                        NavigationLink(value: index) {
                            showProjectName(project)
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { index in
                ProjectView(project: $repository.projects[index])
            }
        }
        .sheet(isPresented: $showTemplateList) {
            TemplateListView()
        }
    }
    
    func showProjectName(_ project: Project) -> some View {
        Text(project.name)
    }
    
}

#Preview {
    ProjectListView()
}

extension Int: Identifiable {
    public var id: Int { self }
}
