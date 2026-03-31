import Foundation

public protocol AlgorithmRunning {
    func supportedAlgorithms() -> [AlgorithmDescriptor]
    func run(_ algorithmID: String, input: AlgorithmInput) throws -> AlgorithmRunResult
}

