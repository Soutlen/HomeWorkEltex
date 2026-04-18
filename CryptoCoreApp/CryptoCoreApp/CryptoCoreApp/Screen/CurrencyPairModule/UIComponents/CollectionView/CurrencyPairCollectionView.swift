//
//  CurrencyPairCollectionView.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CurrencyPairCollectionView: UICollectionView {
    private var currencies: [CurrencyModel] = []

    weak var presenter: CurrencyPairScreenPresenterInput?
    
    private let placeholderLabel = UILabel()

    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: CurrencyPairCollectionViewLayout()
        )
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with currencies: [CurrencyModel], showEmptyFavoritesPlaceholder: Bool) {
        self.currencies = currencies
        reloadData()
        if currencies.isEmpty && showEmptyFavoritesPlaceholder {
            showPlaceholder()
        } else {
            hidePlaceholder()
        }
    }
}

private extension CurrencyPairCollectionView {
    func setupUI() {
        backgroundColor = .clear
        dataSource = self
        delegate = self

        register(
            CurrencyPairCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrencyPairCollectionViewCell.reuseIdentifier
        )
        
        addSubviews()
        setupLabel()
        setupConstraits()
    }
    
    func addSubviews() {
        self.addSubview(placeholderLabel)
    }
    
    func setupLabel() {
        placeholderLabel.text = "Нет избранных валют"
        placeholderLabel.textAlignment = .center
        placeholderLabel.textColor = .systemGray
        placeholderLabel.font = Theme.fontDesignSystem.regular(size: 16)
    }

    func showPlaceholder() {
        placeholderLabel.isHidden = false
    }
    
    func hidePlaceholder() {
        placeholderLabel.isHidden = true
    }
    
    func setupConstraits() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension CurrencyPairCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return currencies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: CurrencyPairCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? CurrencyPairCollectionViewCell else { fatalError("Unexpected cell type") }

        let currency = currencies[indexPath.item]
        cell.configure(currency: currency)
        cell.delegate = self
        return cell
    }
}

extension CurrencyPairCollectionView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.item < currencies.count else { return }

        let currency = currencies[indexPath.item]
        presenter?.chooseCurrency(currency)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CurrencyPairCollectionView: CurrencyPairCollectionViewCellDelegate {
    func currencyCollectionViewCell(
        _ cell: CurrencyPairCollectionViewCell,
        didSelectFavorite currency: CurrencyModel
    ) {
        presenter?.toggleFavorite(for: currency.currency)
    }
}


