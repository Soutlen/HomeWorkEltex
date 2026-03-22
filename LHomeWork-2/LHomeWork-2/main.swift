//
//  main.swift
//  LHomeWork-2
//
//  Created by Евгений Глоба on 3/15/26.
//

import Foundation

func main() {
    let portfolio = Portfolio(balanceUSD: 1000, balanceBTC: 0)
    let exchange = Exchange(portfolio: portfolio)
    let strategy = TradeStrategy()
    let priceGenerator = PriceGenerator()
    
    let bot = SalesBot(
        exchange: exchange,
        strategy: strategy,
        priceGenerator: priceGenerator,
        iteration: 10
    )
    
    bot.runSimulation()
    
    print(
"""
Final portfolio: 
USD=\(String(format: "%.2f", exchange.portfolio.balanceUSD)) 
BTC=\(String(format: "%.2f", exchange.portfolio.balanceBTC)) 
""")
}

main()
