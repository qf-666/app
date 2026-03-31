import Foundation

public protocol AlgorithmDemo {
    var descriptor: AlgorithmDescriptor { get }
    func runDemo(input: AlgorithmInput) throws -> AlgorithmRunResult
}

public enum AlgorithmDemoError: LocalizedError, Equatable {
    case unsupportedAlgorithm(String)
    case invalidOutput(String)

    public var errorDescription: String? {
        switch self {
        case .unsupportedAlgorithm(let algorithmID):
            return "Unsupported algorithm: \(algorithmID)"
        case .invalidOutput(let reason):
            return reason
        }
    }
}

