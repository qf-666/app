import XCTest
@testable import CryptoAlgorithmKit

final class AlgorithmRegistryTests: XCTestCase {
    func testRegistryListsTheSM2Descriptor() {
        let registry = AlgorithmRegistry()

        let descriptors = registry.supportedAlgorithms()

        XCTAssertEqual(descriptors.map(\.id), ["sm2"])
        XCTAssertEqual(descriptors.first?.name, "SM2")
    }

    func testUnsupportedAlgorithmThrowsADomainError() {
        let registry = AlgorithmRegistry()

        XCTAssertThrowsError(
            try registry.run("unknown", input: AlgorithmInput(message: "demo"))
        ) { error in
            XCTAssertEqual(error as? AlgorithmDemoError, .unsupportedAlgorithm("unknown"))
        }
    }
}

