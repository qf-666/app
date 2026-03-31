import Foundation

public struct AlgorithmInput: Equatable {
    public var message: String
    public var userID: String

    public init(message: String, userID: String = "1234567812345678") {
        self.message = message
        self.userID = userID
    }
}

