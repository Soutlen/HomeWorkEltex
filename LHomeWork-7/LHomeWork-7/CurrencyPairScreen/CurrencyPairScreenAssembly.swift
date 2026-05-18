//
//  CurrencyPairScreenAssembly.swift
//  LHomeWork-7
//
//  Created by Евгений Глоба on 4/5/26.
//

import UIKit

final class CurrencyPairScreenAssembly {
    static func makeViewController() -> CurrencyPairScreenViewController {
        let currencies = CurrencyPairModelGenerator.generateCurrencies(count: 100)

        let presenter = CurrencyPairScreenPresenter(currencies: currencies)

        let contentView = CurrencyPairScreenView()

        presenter.view = contentView

        let viewController = CurrencyPairScreenViewController(
            presenter: presenter
        )

        return viewController
    }
}
