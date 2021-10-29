

import Foundation
//import Logging

public enum MobileCoinMinimalError: Error {
    case invalidReceipt
}

// MARK: -

public class MobileCoinMinimal {
    
//    public enum MobileCoinLogging {
//        public static var logSensitiveData = false {
//            willSet {
//                guard logSensitiveDataInternal.set(newValue) else {
//                    logger.preconditionFailure(
//                        "logSensitiveData can only be set prior to using the MobileCoin SDK.")
//                }
//            }
//        }
//    }
    
//    private static let logger = Logger(label: "com.mobilecoin.minimal", factory: ContextPrefixLogHandler.init)
//    internal let logger = Logger(label: "com.mobilecoin", factory: ContextPrefixLogHandler.init)

    public static func txOutPublicKey(forReceiptData serializedData: Data) throws -> Data {
        guard let proto = try? External_Receipt(serializedData: serializedData) else {
            logger.warning(
                "External_Receipt deserialization failed. serializedData: " +
                "\(redacting: serializedData.base64EncodedString())",
                logFunction: false)
            throw MobileCoinMinimalError.invalidReceipt
        }
        let txOutPublicKey = proto.publicKey.data
        return txOutPublicKey
    }
}

