//
//  SalesBot.swift
//  LHomeWork-5
//
//  Created by Евгений Глоба on 3/23/26.
//

import Foundation

protocol SalesBotProtocol: AnyObject {
    func runSimulation() -> [String]
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
    
    func runSimulation() -> [String] {
        
        var result: [String] = []
        
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
                result.append("Step \(i+1): BUY at \(String(format: "%.2f", price))")
            case .sell:
                _ = exchange.tradeAll(isBuying: false, price: price)
                result.append("Step \(i+1): SELL at \(String(format: "%.2f", price))")
            case .hold:
                result.append("Step \(i+1): HOLD at \(String(format: "%.2f", price))")
            }
        }
        
        result.append("")
        result.append("USD: \(String(format: "%.2f", exchange.portfolio.balanceUSD))")
        result.append("BTC: \(String(format: "%.6f", exchange.portfolio.balanceBTC))")
        
        if let buyPrice = exchange.portfolio.buyPrice {
            result.append("Цена покупки: \(String(format: "%.2f", buyPrice))")
        }
        
        return result
    }
}
