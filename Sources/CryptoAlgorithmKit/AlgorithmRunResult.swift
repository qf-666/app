import Foundation

public struct AlgorithmResultField: Equatable, Identifiable {
    public let key: String
    public let title: String
    public let value: String

    public var id: String {
        key
    }

    public init(key: String, title: String, value: String) {
        self.key = key
        self.title = title
        self.value = value
    }
}

public struct AlgorithmRunResult: Equatable {
    public let algorithmID: String
    public let algorithmName: String
    public let summary: String
    public let fields: [AlgorithmResultField]

    public init(
        algorithmID: String,
        algorithmName: String,
        summary: String,
        fields: [AlgorithmResultField]
    ) {
        self.algorithmID = algorithmID
        self.algorithmName = algorithmName
        self.summary = summary
        self.fields = fields
    }

    public func value(for key: String) -> String? {
        fields.first(where: { $0.key == key })?.value
    }
}

