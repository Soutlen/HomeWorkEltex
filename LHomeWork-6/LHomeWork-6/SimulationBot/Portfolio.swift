//
//  Portfolio.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import Foundation

struct Portfolio {
    var buyPrice: Double?
    var balanceUSD: Double
    var balanceBTC: Double
}

enum TradeAction {
    case buy
    case sell
    case hold
}

struct TradeStep {
    let step: Int
    let action: TradeAction
    let price: Double
    let description: String
}
