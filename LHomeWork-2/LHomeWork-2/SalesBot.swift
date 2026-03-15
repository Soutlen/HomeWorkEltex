//
//  SalesBot.swift
//  LHomeWork-2
//
//  Created by Евгений Глоба on 3/15/26.
//

import Foundation

protocol ISalesBot: AnyObject {
    func runSimulation()
}

final class SalesBot: ISalesBot {
    private let exchange: Exchange
    private let strategy: TradeStrategy
    private let priceGenerator: PriceGenerator
    private let iteration: Int
    
    init(
        exchange: Exchange,
        strategy: TradeStrategy,
        priceGenerator: PriceGenerator,
        iteration: Int
    ) {
        self.exchange = exchange
        self.strategy = strategy
        self.priceGenerator = priceGenerator
        self.iteration = iteration
    }
    
    func runSimulation() {
        for i in 0..<iteration {
            let price = priceGenerator.nextPrice()
            let action = strategy.choiseAction(
                price: price,
                portfoilio: exchange.portfolio
            )
            
            switch action {
            case .buy:
                _ = exchange.buyAllUSD(price: price)
                print("Step \(i + 1): BUY at \(String(format: "%.2f", price))")
            case .sell:
                _ = exchange.sellAllBTC(price: price)
                print("Step \(i + 1): SELL at \(String(format: "%.2f", price))")
            case .hold:
                print("Step \(i + 1): HOLD at \(String(format: "%.2f", price))")
            }
        }
    }
}
