//
//  ProjectRepository.swift
//  TravelBrochure
//
//  Created by kakeru on 2024/05/01.
//

import Foundation
import Observation
import SwiftUI
import SwiftyToys

@Observable
class ProjectRepository {
    private let storage = container.resolve(IStorage.self)
    private let key = StorageKey(file: "ProjectRepository.projects")
    
    var projects: [Project] = []
    
    init() {
        load()
    }
    
    func load() {
        projects = (try? storage.get(key, type: [Project].self)) ?? []
    }
    
    func save() {
        try? storage.upsert(key, value: projects)
    }
}
