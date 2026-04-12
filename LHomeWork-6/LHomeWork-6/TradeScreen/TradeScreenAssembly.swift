//
//  TradeScreenAssembly.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/30/26.
//

import UIKit

final class TradeScreenAssembly {
    static func makeTradeScreen() -> UIViewController {
        let profile = Portfolio(
            buyPrice: nil,
            balanceUSD: 1000,
            balanceBTC: 0
        )
        let exchange = ExchangeCurrencySimulation(portfolio: profile)
        let strategy = TradeStrategyExchangeCurrency()
        let priceGenerator = PriceGeneratorCurrency()
        let bot = TradingСurrencyBot(
            exchangeCurrencySimulation: exchange,
            strategy: strategy,
            priceGenerator: priceGenerator
        )
        
        let useCase = TradeSimulationUseCase(
            bot: bot,
            iteration: 30
        )
        
        let presenter = TradeScreenPresenter(useCase: useCase)
        let viewController = TradeScreenViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
