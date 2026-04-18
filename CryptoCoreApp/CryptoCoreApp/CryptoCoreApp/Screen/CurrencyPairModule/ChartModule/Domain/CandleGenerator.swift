//
//  CandleGenerator.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/17/26.
//

import Foundation

enum CandleGenerator {
    static func generate(count: Int) -> [CandleModel] {
        guard count > 0 else { return [] }

        var candles: [CandleModel] = []
        var previousClose = Double.random(in: 80...120)

        for id in 0..<count {
            let open = previousClose
            let delta = Double.random(in: -8...8)
            let close = max(1, open + delta)

            let upperWick = Double.random(in: 1...6)
            let lowerWick = Double.random(in: 1...6)

            let high = max(open, close) + upperWick
            let low = max(0.1, min(open, close) - lowerWick)

            candles.append(
                CandleModel(
                    id: id,
                    openCandel: open,
                    closeCandel: close,
                    highCandel: high,
                    lowCandel: low
                )
            )

            previousClose = close
        }

        return candles
    }
}
