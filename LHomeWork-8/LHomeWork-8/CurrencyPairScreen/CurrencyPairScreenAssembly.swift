//
//  CurrencyPairScreenAssembly.swift
//  LHomeWork-8
//
//  Created by Евгений Глоба on 4/9/26.
//

import UIKit

final class CurrencyPairScreenAssembly {
    static func makeViewController() -> CurrencyPairScreenViewController {
        let currencies = CurrencyPairModelGenerator.generateCurrencies(count: 100)

        let presenter = CurrencyPairScreenPresenter(currencies: currencies)

        let viewController = CurrencyPairScreenViewController(
            presenter: presenter
        )

        return viewController
    }
}
