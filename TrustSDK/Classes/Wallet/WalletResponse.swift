// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustWalletCore

public extension WalletSDK {
    enum Response {
        case sign(coin: CoinType, output: Data)
        case signThenSend(txHash: String)
        case accounts([String])
        case failure(error: TrustSDKError)

        var params: [String: String] {
            switch self {
            case .sign(let coin, let output):
                return [
                    "coin": "\(coin.rawValue)",
                    "data": output.base64UrlEncodedString(),
                ]
            case .accounts(let accounts):
                return [
                    "accounts": accounts.joined(separator: ","),
                ]
            case .signThenSend(let txHash):
                return [
                    "tx_hash": txHash,
                ]
            case .failure(let error):
                return error.params
            }
        }
    }
}
