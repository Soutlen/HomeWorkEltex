//
//  ChartView.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class ChartView: UIView {
    var onSelectCandle: ((Int) -> Void)?
    var onLongPressCandle: ((Int) -> Void)?

    private(set) var candles: [CandleModel] = []
    private var selectedIndex: Int = 0

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CandleCollectionViewLayout())

    private let pairLabel = UILabel()
    private let openLabel = UILabel()
    private let closeLabel = UILabel()
    private let highLabel = UILabel()
    private let lowLabel = UILabel()
    private let recommendationTitleLabel = UILabel()
    private let recommendationValueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCandles(_ candles: [CandleModel]) {
        self.candles = candles
        collectionView.reloadData()
    }

    func updateSelectedIndex(_ index: Int) {
        selectedIndex = index
        collectionView.reloadData()
    }

    func updatePairTitle(base: String, counter: String) {
        pairLabel.text = "\(base)/\(counter)"
    }

    func updateSelectedCandleInfo(_ candle: CandleModel) {
        openLabel.text = "Open: \(String(format: "%.2f", candle.openCandel))"
        closeLabel.text = "Close: \(String(format: "%.2f", candle.closeCandel))"
        highLabel.text = "High: \(String(format: "%.2f", candle.highCandel))"
        lowLabel.text = "Low: \(String(format: "%.2f", candle.lowCandel))"
    }

    func updateRecommendation(_ action: TradeAction) {
        switch action {
        case .buy: recommendationValueLabel.text = "Покупать"
        case .sell: recommendationValueLabel.text = "Продавать"
        case .hold: recommendationValueLabel.text = "Ждать"
        }
    }
}

private extension ChartView {
    func setupUI() {
        backgroundColor = Theme.colorDesignSystem.green

        addSubviews()
        setupConstraints()
        setupLabels()
        setupCollection()
    }
    
    func addSubviews() {
        addSubview(pairLabel)
        addSubview(collectionView)
        addSubview(openLabel)
        addSubview(closeLabel)
        addSubview(highLabel)
        addSubview(lowLabel)
        addSubview(recommendationTitleLabel)
        addSubview(recommendationValueLabel)
    }
    
    func setupConstraints() {
        pairLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        openLabel.translatesAutoresizingMaskIntoConstraints = false
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pairLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            pairLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pairLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            collectionView.topAnchor.constraint(equalTo: pairLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 190),

            openLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            openLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            closeLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 8),
            closeLabel.leadingAnchor.constraint(equalTo: openLabel.leadingAnchor),

            highLabel.topAnchor.constraint(equalTo: closeLabel.bottomAnchor, constant: 8),
            highLabel.leadingAnchor.constraint(equalTo: openLabel.leadingAnchor),

            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 8),
            lowLabel.leadingAnchor.constraint(equalTo: openLabel.leadingAnchor),

            recommendationTitleLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 20),
            recommendationTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            recommendationValueLabel.topAnchor.constraint(equalTo: recommendationTitleLabel.bottomAnchor, constant: 8),
            recommendationValueLabel.leadingAnchor.constraint(equalTo: recommendationTitleLabel.leadingAnchor)
        ])
    }
    
    func setupLabels() {
        pairLabel.textColor = .white
        pairLabel.font = Theme.fontDesignSystem.bold(size: 20)
        pairLabel.textAlignment = .center

        [openLabel, closeLabel, highLabel, lowLabel].forEach {
            $0.textColor = .white
            $0.font = Theme.fontDesignSystem.regular(size: 15)
        }

        recommendationTitleLabel.text = "Рекомендация"
        recommendationTitleLabel.textColor = .white.withAlphaComponent(0.8)
        recommendationTitleLabel.font = Theme.fontDesignSystem.medium(size: 14)

        recommendationValueLabel.textColor = .white
        recommendationValueLabel.font = Theme.fontDesignSystem.bold(size: 18)
    }
    
    func setupCollection() {
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        collectionView.layer.cornerRadius = 12
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CandleCollectionViewCell.self, forCellWithReuseIdentifier: CandleCollectionViewCell.reuseIdentifier)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPress)
    }

    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        let point = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        onLongPressCandle?(indexPath.item)
    }
}

extension ChartView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        candles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CandleCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? CandleCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let candle = candles[indexPath.item]
        let isSelected = indexPath.item == selectedIndex
        let maxRange = candles.map { $0.highCandel - $0.lowCandel }.max() ?? 1
        let scale = CGFloat(120 / max(maxRange, 1))

        cell.configure(with: candle, scale: scale, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectCandle?(indexPath.item)
    }
}
