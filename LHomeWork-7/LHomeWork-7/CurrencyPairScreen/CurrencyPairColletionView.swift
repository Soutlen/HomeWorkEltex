//
//  CurrencyPairColletionView.swift
//  LHomeWork-7
//
//  Created by Евгений Глоба on 4/5/26.
//

import UIKit

final class CurrencyPairCollectionView: UICollectionView {
    private var currencies: [CurrencyModel] = []

    weak var presenter: CurrencyPairScreenPresenterInput?

    init() {
        super.init(frame: .zero, collectionViewLayout: CurrencyPairCollectionViewLayout())
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear
        dataSource = self
        delegate = self

        register(
            CurrencyPairCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrencyPairCollectionViewCell.identifier
        )
    }

    func configure(with currencies: [CurrencyModel]) {
        self.currencies = currencies
        reloadData()
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
            withReuseIdentifier: CurrencyPairCollectionViewCell.identifier,
            for: indexPath
        ) as? CurrencyPairCollectionViewCell else { fatalError("Unexpected cell type") }

        let currency = currencies[indexPath.item]
        cell.configure(currency: currency, isHighlighted: false)
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
