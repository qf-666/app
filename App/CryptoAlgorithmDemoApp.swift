import SwiftUI

@main
struct CryptoAlgorithmDemoApp: App {
    @StateObject private var viewModel = DemoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

