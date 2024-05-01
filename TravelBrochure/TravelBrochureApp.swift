//
//  TravelBrochureApp.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/01.
//

import SwiftUI

@main
struct TravelBrochureApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                ProjectRepository.shared.save()
                TicketRepository.shared.save()
            @unknown default:
                print("unknown")
            }
        }
    }
}
