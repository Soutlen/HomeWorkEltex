//
//  CurrencyPairScreenAssembly.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import UIKit

final class CurrencyPairScreenAssembly {
    static func buildViewController() -> CurrencyPairScreenViewController {
        let currencies = CurrencyPairModelGenerator.generateCurrencies(count: 100)

        let presenter = CurrencyPairScreenPresenter(currencies: currencies)

        let viewController = CurrencyPairScreenViewController(
            presenter: presenter
        )

        return viewController
    }
}
