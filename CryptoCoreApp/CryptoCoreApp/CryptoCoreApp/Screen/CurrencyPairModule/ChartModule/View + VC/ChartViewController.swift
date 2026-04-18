//
//  ChartViewController.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class ChartViewController: UIViewController {
    private let contentView = ChartView()
    private let output: ChartViewOutput

    init(output: ChartViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "График"
        navigationItem.largeTitleDisplayMode = .never

        contentView.onSelectCandle = { [weak self] index in
            self?.output.didSelectCandle(at: index)
        }

        contentView.onLongPressCandle = { [weak self] index in
            self?.output.didLongPressCandle(at: index)
        }

        output.viewDidLoad()
        
    }
}

extension ChartViewController: ChartViewInput {
    func showCandles(_ candles: [CandleModel]) {
        contentView.updateCandles(candles)
    }

    func showSelectedCandle(_ candle: CandleModel) {
        contentView.updateSelectedCandleInfo(candle)
        contentView.updateSelectedIndex(candle.id)
    }

    func showRecommendation(_ action: TradeAction) {
        contentView.updateRecommendation(action)
    }

    func showPairTitle(base: String, counter: String) {
        contentView.updatePairTitle(base: base, counter: counter)
    }
}


