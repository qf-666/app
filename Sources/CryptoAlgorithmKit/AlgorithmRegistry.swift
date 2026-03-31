import Foundation

public final class AlgorithmRegistry {
    private let demos: [any AlgorithmDemo]

    public init(demos: [any AlgorithmDemo] = [SM2Algorithm()]) {
        self.demos = demos
    }

    public func supportedAlgorithms() -> [AlgorithmDescriptor] {
        demos
            .map(\.descriptor)
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    public func run(_ algorithmID: String, input: AlgorithmInput) throws -> AlgorithmRunResult {
        guard let demo = demos.first(where: { $0.descriptor.id == algorithmID }) else {
            throw AlgorithmDemoError.unsupportedAlgorithm(algorithmID)
        }

        return try demo.runDemo(input: input)
    }
}

