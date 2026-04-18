//
//  CurrencyPairModel.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

struct CurrencyModel: Equatable {
    let currency: String
    let type: CurrencyType
    var isFavorite: Bool
}

enum CurrencyType {
    case fiat
    case crypto
}

struct CurrencyPair {
    let base: CurrencyModel
    let counter: CurrencyModel
}

enum CurrencyPairSlot {
    case base
    case counter
}

enum CurrencyPairScreenDisplayState: Equatable {
    case empty
    case active(rate: Double)
}

final class CurrencyPairModelGenerator {
    private static let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    private static func randomCurrency() -> String {
        let length = Int.random(in: 3...5)
        let code = (0..<length)
            .map { _ in letters.randomElement()! }
            .map { String($0) }
            .joined()
        return code
    }

    static func generateCurrencies(count: Int) -> [CurrencyModel] {
        var seen = Set<String>()
        var result: [CurrencyModel] = []

        while result.count < count {
            let code = randomCurrency()
            if seen.insert(code).inserted {
                let type: CurrencyType = Bool.random() ? .fiat : .crypto
                result.append(
                    CurrencyModel(
                        currency: code,
                        type: type,
                        isFavorite: false
                    )
                )
            }
        }

        return result
    }
}

