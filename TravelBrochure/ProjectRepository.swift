//
//  ProjectRepository.swift
//  TravelBrochure
//
//  Created by kakeru on 2024/05/01.
//

import Foundation
import SwiftUI
import SwiftyToys

class ProjectRepository: ObservableObject {
    private let storage = container.resolve(IStorage.self)
    private let key = StorageKey(file: "ProjectRepository.projects")
    
    @Published var projects: [Project] = []
    
    
    static let shared = ProjectRepository()
    private init() {
        load()
    }
    
    func load() {
        do {
            let projects = try storage.get(key, type: [Project].self)
            self.projects = projects

        } catch {
            print(error)
        }
    }
    
    func save() {
        try? storage.upsert(key, value: projects)
    }
    
    func add(_ project: Project) {
        projects.append(project)
    }
    
    func delete(_ project: Project) {
        projects.removeAll {
            let result = $0.id == project.id
            if result {
                print("delete project: \(project.name)")
            }
            return result
        }
    }
    

}
