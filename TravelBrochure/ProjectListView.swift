import SwiftUI
import SwiftyToys

struct ProjectListView: View {
    @State private var repository = ProjectRepository()
    
    init() {
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ProjectListView()
}
