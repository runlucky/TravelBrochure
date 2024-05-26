import Foundation
import SwiftUI
import SwiftyToys

internal class TemplateRepository: ObservableObject {
    private let storage = container.resolve(IStorage.self)
    private let key = StorageKey(file: "TemplateRepository.tempaltes")
    
    @Published internal var templates: [Template] = []
    
    
    internal static let shared = TemplateRepository()
    private init() {
        load()
    }
    
    func load() {
        do {
            self.templates = try storage.get(key, type: [Template].self)

        } catch {
            print(error)
        }
    }
    
    func save() {
        try? storage.upsert(key, value: templates)
    }
    
    func upsert(_ template: Template) {
        templates.append(template)
    }
    
    func delete(_ template: Template) {
        templates.removeAll {
            let result = $0.id == template.id
            if result {
                print("delete template: \(template.name)")
            }
            return result
        }
    }
    

}
