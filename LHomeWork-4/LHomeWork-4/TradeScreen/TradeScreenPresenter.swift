//
//  TradeScreenPresenter.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/22/26.
//

import Foundation

protocol TradeScreenPresenterProtocol: AnyObject {
    func showText(_ text: [String])
}

final class TradeScreenPresenter {
    weak var view: TradeScreenPresenterProtocol?
    
    func buttonTapped() {
        let text = runSimulation()
        view?.showText(text)
    }
    
    private func runSimulation() -> [String] {
        let portfolio = Portfolio(buyPrice: nil, balanceUSD: 1000, balanceBTC: 0)
        let exchange = Exchange(portfolio: portfolio)
        let strategy = TradeStrategy()
        let priceGenerator = PriceGenerator()
        
        let bot = SalesBot(
            exchange: exchange,
            strategy: strategy,
            priceGenerator: priceGenerator,
            iteration: 10
        )
        
        return bot.runSimulation()
    }
}
