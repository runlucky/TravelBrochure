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
            TabView {
                ContentView()
                    .tabItem { Label("プロジェクト一覧", systemImage: "star")}
                
                NavigationStack {
                    LogView()
                }
                    .tabItem { Label("ログ", systemImage: "circle")}
            }
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
                TemplateRepository.shared.save()
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
