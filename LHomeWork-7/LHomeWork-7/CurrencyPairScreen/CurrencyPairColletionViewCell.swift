//
//  CurrencyPairColletionViewCell.swift
//  LHomeWork-7
//
//  Created by Евгений Глоба on 4/5/26.
//

import UIKit

final class CurrencyPairCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CurrencyPairCollectionViewCell"

    private let currencyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(currency: CurrencyModel, isHighlighted: Bool) {
        currencyLabel.text = currency.currency
    }
}

private extension CurrencyPairCollectionViewCell {
    func setupUI() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = Theme.sizeDesignSystem.CornerRadius.medium
        self.contentView.backgroundColor = Theme.colorDesignSystem.orange
        self.contentView.layer.cornerRadius = Theme.sizeDesignSystem.CornerRadius.medium
        self.contentView.layer.masksToBounds = true
        
        addSubviews()
        setupLabel()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(currencyLabel)
    }
    
    func setupLabel() {
        currencyLabel.textColor = Theme.colorDesignSystem.black
        currencyLabel.textAlignment = .center
        currencyLabel.font = Theme.fontDesignSystem.regular(size: 24)
        currencyLabel.numberOfLines = 1
    }
    
    func setupConstraints() {
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 20)
        ])
    }
}
