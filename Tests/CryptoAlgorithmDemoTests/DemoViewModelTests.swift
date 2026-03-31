import XCTest
@testable import CryptoAlgorithmDemo
import CryptoAlgorithmKit

@MainActor
final class DemoViewModelTests: XCTestCase {
    func testSelectingAlgorithmRunsItImmediately() {
        let registry = MockAlgorithmRegistry()
        let viewModel = DemoViewModel(registry: registry)

        viewModel.selectAlgorithmAndRun("sm2")

        XCTAssertEqual(viewModel.selectedAlgorithmID, "sm2")
        XCTAssertEqual(viewModel.result?.algorithmID, "sm2")
        XCTAssertEqual(viewModel.result?.value(for: "message"), "Hello from iOS SM2 demo")
        XCTAssertEqual(viewModel.errorMessage, nil)
    }

    func testRunFailureShowsErrorMessage() {
        let registry = MockAlgorithmRegistry(shouldThrow: true)
        let viewModel = DemoViewModel(registry: registry)

        viewModel.selectAlgorithmAndRun("sm2")

        XCTAssertNil(viewModel.result)
        XCTAssertEqual(viewModel.errorMessage, "mock failure")
    }
}

private struct MockAlgorithmRegistry: AlgorithmRunning {
    var shouldThrow = false

    func supportedAlgorithms() -> [AlgorithmDescriptor] {
        [
            AlgorithmDescriptor(
                id: "sm2",
                name: "SM2",
                summary: "Test algorithm"
            )
        ]
    }

    func run(_ algorithmID: String, input: AlgorithmInput) throws -> AlgorithmRunResult {
        if shouldThrow {
            throw MockError.failure
        }

        return AlgorithmRunResult(
            algorithmID: algorithmID,
            algorithmName: "SM2",
            summary: "Mock success",
            fields: [
                AlgorithmResultField(key: "message", title: "Message", value: input.message)
            ]
        )
    }
}

private enum MockError: LocalizedError {
    case failure

    var errorDescription: String? {
        "mock failure"
    }
}
