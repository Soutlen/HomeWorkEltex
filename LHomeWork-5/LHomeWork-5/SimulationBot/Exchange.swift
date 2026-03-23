//
//  Exchange.swift
//  LHomeWork-5
//
//  Created by Евгений Глоба on 3/23/26.
//

import Foundation

protocol ExchangeProtocol: AnyObject {
    var portfolio: Portfolio { get }
    
    func tradeAll(isBuying: Bool, price: Double) -> Bool
}

final class Exchange: ExchangeProtocol {
    private(set) var portfolio: Portfolio
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
    }
    
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
