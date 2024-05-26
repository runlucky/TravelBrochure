import Foundation
import SwiftUI
import SwiftyToys

struct TemplateListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var repository = TemplateRepository.shared
    @State private var showTemplate = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(Array(repository.templates.enumerated()), id: \.element.id) { index, template in
                        NavigationLink(value: index) {
                            Text(template.name)
                        }
                    }
                }

                Button("新しいテンプレートを追加") {
                    showTemplate = true
                }
            }
            .navigationDestination(for: Int.self) { index in
                TemplateView(template: $repository.templates[index])
            }
            .sheet(isPresented: $showTemplate) {
                Text("this is template")
            }
            .navigationTitle("テンプレートの選択")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }

        }
    }
    
    func showProjectName(_ project: Project) -> some View {
        Text(project.name)
    }
    
}

#Preview {
    TemplateListView()
}

