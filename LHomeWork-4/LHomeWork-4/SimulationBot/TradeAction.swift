//
//  TradeAction.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import Foundation

enum TradeAction {
    case buy
    case sell
    case hold
}

protocol ITradeStrategy {
    func choiseAction(price: Double, portfoilio: Portfolio) -> TradeAction
}

struct TradeStrategy: ITradeStrategy {
    func choiseAction(price: Double, portfoilio: Portfolio) -> TradeAction {
        if portfoilio.balanceBTC > 0 {
            guard let buyPrice = portfoilio.buyPrice else { return .hold }
            return price >= buyPrice * 1.2 ? .sell : .hold
        } else {
            return price < 800 ? .buy : .hold
        }
    }
}
