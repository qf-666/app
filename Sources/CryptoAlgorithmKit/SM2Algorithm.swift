import Foundation
import GMObjC

public struct SM2Algorithm: AlgorithmDemo {
    public let descriptor = AlgorithmDescriptor(
        id: "sm2",
        name: "SM2",
        summary: "演示密钥生成、加密解密、签名与验签。"
    )

    public init() {}

    public func runDemo(input: AlgorithmInput) throws -> AlgorithmRunResult {
        let message = input.message.isEmpty ? "Hello from iOS SM2 demo" : input.message
        let userID = input.userID.isEmpty ? "1234567812345678" : input.userID

        guard let keyPair = GMSm2Utils.generateKey(),
              let publicKey = keyPair.publicKey,
              let privateKey = keyPair.privateKey else {
            throw AlgorithmDemoError.invalidOutput("Failed to generate an SM2 key pair.")
        }

        guard let encryptedPayload = GMSm2Utils.encryptText(message, publicKey: publicKey) else {
            throw AlgorithmDemoError.invalidOutput("SM2 encryption returned no payload.")
        }

        guard let decryptedMessage = GMSm2Utils.decryptHex(encryptedPayload, privateKey: privateKey) else {
            throw AlgorithmDemoError.invalidOutput("SM2 decryption returned no plaintext.")
        }

        guard decryptedMessage == message else {
            throw AlgorithmDemoError.invalidOutput("SM2 decrypted text did not match the original message.")
        }

        guard let signature = GMSm2Utils.signText(message, privateKey: privateKey, userText: userID) else {
            throw AlgorithmDemoError.invalidOutput("SM2 signing returned no signature.")
        }

        let verified = GMSm2Utils.verifyText(
            message,
            signRS: signature,
            publicKey: publicKey,
            userText: userID
        )

        guard verified else {
            throw AlgorithmDemoError.invalidOutput("SM2 signature verification failed.")
        }

        return AlgorithmRunResult(
            algorithmID: descriptor.id,
            algorithmName: descriptor.name,
            summary: "SM2 round-trip completed successfully.",
            fields: [
                AlgorithmResultField(key: "message", title: "原始明文", value: message),
                AlgorithmResultField(key: "userID", title: "User ID", value: userID),
                AlgorithmResultField(key: "publicKey", title: "公钥", value: publicKey),
                AlgorithmResultField(key: "privateKey", title: "私钥", value: privateKey),
                AlgorithmResultField(key: "encryptedPayload", title: "密文", value: encryptedPayload),
                AlgorithmResultField(key: "decryptedMessage", title: "解密结果", value: decryptedMessage),
                AlgorithmResultField(key: "signature", title: "签名", value: signature),
                AlgorithmResultField(key: "signatureVerified", title: "验签结果", value: String(verified))
            ]
        )
    }
}

