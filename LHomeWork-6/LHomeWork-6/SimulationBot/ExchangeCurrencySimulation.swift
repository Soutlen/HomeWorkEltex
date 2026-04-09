//
//  Exchange.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

protocol ExchangeCurrencySimulationProtocol: AnyObject {
    var portfolio: Portfolio { get }
    
    func tradeAll(isBuying: Bool, price: Double) -> Bool
}

final class ExchangeCurrencySimulation {
    private(set) var portfolio: Portfolio
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
    }
}

extension ExchangeCurrencySimulation: ExchangeCurrencySimulationProtocol {
    func tradeAll(isBuying: Bool, price: Double) -> Bool {
        guard price > 0 else { return false }
    
        if isBuying {
            guard portfolio.balanceUSD > 0 else { return false }
            let btc = portfolio.balanceUSD / price
            portfolio.balanceBTC += btc
            portfolio.balanceUSD = 0
            portfolio.buyPrice = price
        } else {
            guard portfolio.balanceBTC > 0 else { return false }
            let usd = portfolio.balanceBTC * price
            portfolio.balanceUSD += usd
            portfolio.balanceBTC = 0
            portfolio.buyPrice = nil
        }
        return true
    }
}
