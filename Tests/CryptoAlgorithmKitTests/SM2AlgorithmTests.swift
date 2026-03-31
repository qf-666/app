import XCTest
@testable import CryptoAlgorithmKit

final class SM2AlgorithmTests: XCTestCase {
    func testSM2DemoEncryptsDecryptsAndVerifies() throws {
        let algorithm = SM2Algorithm()
        let result = try algorithm.runDemo(
            input: AlgorithmInput(
                message: "Hello from XCTest",
                userID: "ios-demo-user"
            )
        )

        XCTAssertEqual(result.algorithmID, "sm2")
        XCTAssertEqual(result.value(for: "decryptedMessage"), "Hello from XCTest")
        XCTAssertEqual(result.value(for: "signatureVerified"), "true")
        XCTAssertFalse((result.value(for: "encryptedPayload") ?? "").isEmpty)
        XCTAssertFalse((result.value(for: "signature") ?? "").isEmpty)
    }
}

