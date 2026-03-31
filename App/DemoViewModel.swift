import Combine
import CryptoAlgorithmKit
import Foundation

@MainActor
final class DemoViewModel: ObservableObject {
    @Published private(set) var availableAlgorithms: [AlgorithmDescriptor]
    @Published var selectedAlgorithmID: String
    @Published var message: String
    @Published var userID: String
    @Published private(set) var result: AlgorithmRunResult?
    @Published private(set) var errorMessage: String?

    private let registry: any AlgorithmRunning

    init(registry: any AlgorithmRunning = AlgorithmRegistry()) {
        self.registry = registry
        self.availableAlgorithms = registry.supportedAlgorithms()
        self.selectedAlgorithmID = self.availableAlgorithms.first?.id ?? "sm2"
        self.message = "Hello from iOS SM2 demo"
        self.userID = "1234567812345678"
    }

    func selectAlgorithmAndRun(_ algorithmID: String) {
        selectedAlgorithmID = algorithmID
        runSelectedDemo()
    }

    func runSelectedDemo() {
        do {
            let input = AlgorithmInput(message: message, userID: userID)
            result = try registry.run(selectedAlgorithmID, input: input)
            errorMessage = nil
        } catch {
            result = nil
            errorMessage = error.localizedDescription
        }
    }
}
