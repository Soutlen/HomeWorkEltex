//
//  ChartPresenter.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/17/26.
//

import Foundation

protocol ChartViewInput: AnyObject {
    func showCandles(_ candles: [CandleModel])
    func showSelectedCandle(_ candle: CandleModel)
    func showRecommendation(_ action: TradeAction)
    func showPairTitle(base: String, counter: String)
}

protocol ChartViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectCandle(at index: Int)
    func didLongPressCandle(at index: Int)
}

final class ChartPresenter: ChartViewOutput {
    weak var view: ChartViewInput?

    private let base: String
    private let counter: String
    private let recommendationStrategy: ChartRecommendationStrategyProtocol

    private var candles: [CandleModel] = []
    private var selectedIndex: Int = 0

    init(
        base: String,
        counter: String,
        recommendationStrategy: ChartRecommendationStrategyProtocol = ChartRecommendationStrategy()
    ) {
        self.base = base
        self.counter = counter
        self.recommendationStrategy = recommendationStrategy
    }

    func viewDidLoad() {
        view?.showPairTitle(base: base, counter: counter)

        candles = CandleGenerator.generate(count: 40)
        view?.showCandles(candles)

        guard let first = candles.first else { return }
        selectedIndex = 0
        view?.showSelectedCandle(first)
        view?.showRecommendation(.hold)
    }

    func didSelectCandle(at index: Int) {
        guard candles.indices.contains(index) else { return }
        selectedIndex = index
        view?.showSelectedCandle(candles[index])
    }

    func didLongPressCandle(at index: Int) {
        guard candles.indices.contains(index) else { return }
        let action = recommendationStrategy.recommendation(for: candles[index])
        view?.showRecommendation(action)
    }
}
