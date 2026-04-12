//
//  SalesBot.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

protocol TradingСurrencyBotProtocol: AnyObject {
    func runSimulationTrading(iteration: Int) -> [TradeStep]
}

final class TradingСurrencyBot {
    private let exchangeCurrencySimulation: ExchangeCurrencySimulation
    private let tradeStrategyExchngeCurrency: TradeStrategyExchangeCurrency
    private let PriceGeneratorCurrency: PriceGeneratorCurrency

    init(
        exchangeCurrencySimulation: ExchangeCurrencySimulation,
        strategy: TradeStrategyExchangeCurrency,
        priceGenerator: PriceGeneratorCurrency,
    ) {
        self.exchangeCurrencySimulation = exchangeCurrencySimulation
        self.tradeStrategyExchngeCurrency = strategy
        self.PriceGeneratorCurrency = priceGenerator
    }
}

extension TradingСurrencyBot: TradingСurrencyBotProtocol {
    func runSimulationTrading(iteration: Int) -> [TradeStep] {
        var steps: [TradeStep] = []

        for i in 0..<iteration {
            let price = PriceGeneratorCurrency.nextPrice()
            let startPrice = PriceGeneratorCurrency.startPrice
            let action = tradeStrategyExchngeCurrency.choiseAction(
                price: price,
                portfoilio: exchangeCurrencySimulation.portfolio,
                priceGenerator: startPrice
            )

            switch action {
            case .buy:
                _ = exchangeCurrencySimulation.tradeAll(isBuying: true, price: price)
            case .sell:
                _ = exchangeCurrencySimulation.tradeAll(isBuying: false, price: price)
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
