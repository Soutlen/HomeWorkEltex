//
//  ChartRecommendationStrategy.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/17/26.
//

import Foundation

protocol ChartRecommendationStrategyProtocol {
    func recommendation(for candle: CandleModel) -> TradeAction
}

struct ChartRecommendationStrategy: ChartRecommendationStrategyProtocol {
    func recommendation(for candle: CandleModel) -> TradeAction {
        let body = abs(candle.closeCandel - candle.openCandel)
        let range = candle.highCandel - candle.lowCandel
        guard range > 0 else { return .hold }

        let bodyToRange = body / range

        if candle.closeCandel > candle.openCandel, bodyToRange > 0.45 {
            return .buy
        } else if candle.closeCandel < candle.openCandel, bodyToRange > 0.45 {
            return .sell
        } else {
            return .hold
        }
    }
}
