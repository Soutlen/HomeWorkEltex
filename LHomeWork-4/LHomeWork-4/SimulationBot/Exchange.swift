//
//  Exchange.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import Foundation

protocol ExchangeProtocol: AnyObject {
    var portfolio: Portfolio { get }
    
    func buyAllUSD(price: Double) -> Bool
    func sellAllBTC(price: Double) -> Bool
}

final class Exchange: ExchangeProtocol {
    private(set) var portfolio: Portfolio
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
    }
    
    func buyAllUSD(price: Double) -> Bool {
        guard portfolio.balanceUSD > 0, price > 0 else { return false }
        let btc = portfolio.balanceUSD / price
        portfolio.balanceBTC += btc
        portfolio.balanceUSD = 0
        portfolio.buyPrice = price
        return true
    }
    
    func sellAllBTC(price: Double) -> Bool {
        guard portfolio.balanceBTC > 0, price > 0 else { return false }
        let usd = portfolio.balanceBTC / price
        portfolio.balanceUSD += usd
        portfolio.balanceUSD = 0
        portfolio.buyPrice = nil
        return true
    }
}
