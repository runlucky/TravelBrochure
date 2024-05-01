import SwiftUI
import SwiftyToys

@main
struct Main: App {
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        registerContainer()
    }
    
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
    
    func registerContainer() {
        container.register(IStorage.self) {
            FileStorage(root: .appSupport)
        }
    }

}
