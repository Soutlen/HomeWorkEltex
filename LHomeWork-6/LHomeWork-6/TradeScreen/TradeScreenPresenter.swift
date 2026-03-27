//
//  TradeScreenPresenter.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

protocol TradeScreenPresenterProtocol: AnyObject {
    func showStepLog(_ steps: [TradeStep])
}

final class TradeScreenPresenter {
    weak var view: TradeScreenPresenterProtocol?

    func buttonTapped() {
        let portfolio = Portfolio(buyPrice: nil, balanceUSD: 1000, balanceBTC: 0)
        let exchange = Exchange(portfolio: portfolio)
        let strategy = TradeStrategy()
        let priceGenerator = PriceGenerator()

        let bot = SalesBot(
            exchange: exchange,
            strategy: strategy,
            priceGenerator: priceGenerator,
            iteration: 30
        )

        let steps = bot.runSimulation()
        view?.showStepLog(steps)
    }
}
