//
//  CandelCollectionViewCell.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CandleCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CandleCollectionViewCell"

    private let candleView = CandleView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(candleView)
        candleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            candleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            candleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            candleView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            candleView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with candle: CandleModel, scale: CGFloat, isSelected: Bool) {
        candleView.configure(with: candle, scale: scale, isSelected: isSelected)
    }
}
