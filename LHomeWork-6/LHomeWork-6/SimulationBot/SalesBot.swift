//
//  SalesBot.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

protocol SalesBotProtocol: AnyObject {
    func runSimulation() -> [TradeStep]
}

final class SalesBot: SalesBotProtocol {
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

    func runSimulation() -> [TradeStep] {
        var steps: [TradeStep] = []

        for i in 0..<iteration {
            let price = priceGenerator.nextPrice()
            let startPrice = priceGenerator.startPrice
            let action = strategy.choiseAction(
                price: price,
                portfoilio: exchange.portfolio,
                priceGenerator: startPrice
            )

            switch action {
            case .buy:
                _ = exchange.tradeAll(isBuying: true, price: price)
            case .sell:
                _ = exchange.tradeAll(isBuying: false, price: price)
            case .hold:
                break
            }

            let description: String
            switch action {
            case .buy:
                description = "Step \(i+1): BUY at \(String(format: "%.2f", price))"
            case .sell:
                description = "Step \(i+1): SELL at \(String(format: "%.2f", price))"
            case .hold:
                description = "Step \(i+1): HOLD at \(String(format: "%.2f", price))"
            }

            steps.append(TradeStep(
                step: i + 1,
                action: action,
                price: price,
                description: description,
            ))
        }

        return steps
    }
}
