//
//  TradeStrategyExchangeCurrency.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

protocol TradeStrategyExchangeCurrencyProtocol {
    func choiseAction(price: Double, portfoilio: Portfolio, priceGenerator: Double) -> TradeAction
}

struct TradeStrategyExchangeCurrency: TradeStrategyExchangeCurrencyProtocol {
    func choiseAction(price: Double, portfoilio: Portfolio, priceGenerator: Double) -> TradeAction {
        if portfoilio.balanceBTC > 0 {
            guard let buyPrice = portfoilio.buyPrice else { return .hold }
            return price >= buyPrice * 1.2 ? .sell : .hold
        } else {
            return price < priceGenerator ? .buy : .hold
        }
    }
}

