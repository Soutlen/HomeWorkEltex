//
//  CurrencyPairCollectionViewCell.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import UIKit

protocol CurrencyPairCollectionViewCellDelegate: AnyObject {
    func currencyCollectionViewCell(
        _ cell: CurrencyPairCollectionViewCell,
        didSelectFavorite currency: CurrencyModel
    )
}

final class CurrencyPairCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "CurrencyPairCollectionViewCell"

    private let currencyLabel = UILabel()
    private let favoriteButton = UIButton()
    
    private var currency: CurrencyModel?
    
    weak var delegate: CurrencyPairCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(currency: CurrencyModel) {
        self.currency = currency
        currencyLabel.text = currency.currency
        updateFavoriteAppearance()
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
        setupButton()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(currencyLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupLabel() {
        currencyLabel.textColor = Theme.colorDesignSystem.black
        currencyLabel.textAlignment = .center
        currencyLabel.font = Theme.fontDesignSystem.regular(size: 24)
        currencyLabel.numberOfLines = 1
    }
    
    func setupButton() {
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteTapped),
            for: .touchUpInside
        )
    }
    
    func updateFavoriteAppearance() {
        guard let currency = currency else { return }
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let image = currency.isFavorite
        ? UIImage(systemName: "star.fill", withConfiguration: config)?.withTintColor(.yellow)
        : UIImage(systemName: "star", withConfiguration: config)?.withTintColor(.systemGray4)
        
        favoriteButton.setImage(image, for: .normal)
    }
    
    func setupConstraints() {
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 16),
            
            favoriteButton.topAnchor.constraint(equalTo: currencyLabel.topAnchor, constant: -4),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    @objc
    func favoriteTapped() {
        guard let currency = currency else { return }
        delegate?.currencyCollectionViewCell(
            self,
            didSelectFavorite: currency
        )
    }
}

