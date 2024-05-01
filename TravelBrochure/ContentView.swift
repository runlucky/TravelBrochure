//
//  ContentView.swift
//  TravelBrochure
//
//  Created by Kakeru Fukuda on 2024/05/01.
//

import SwiftUI
import SwiftyToys

struct ContentView: View {
    init() {
        registerContainer()
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
    
    func registerContainer() {
        container.register(IStorage.self) {
            FileStorage(root: .appSupport)
        }
    }
}

#Preview {
    ContentView()
}
