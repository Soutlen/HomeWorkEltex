//
//  TradeAction.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

protocol TradeStrategyProtocol {
    func choiseAction(price: Double, portfoilio: Portfolio, priceGenerator: Double) -> TradeAction
}

struct TradeStrategy: TradeStrategyProtocol {
    func choiseAction(price: Double, portfoilio: Portfolio, priceGenerator: Double) -> TradeAction {
        if portfoilio.balanceBTC > 0 {
            guard let buyPrice = portfoilio.buyPrice else { return .hold }
            return price >= buyPrice * 1.2 ? .sell : .hold
        } else {
            return price < priceGenerator ? .buy : .hold
        }
    }
}
