//
//  CurrencyPairScreenViewController.swift
//  LHomeWork-8
//
//  Created by Евгений Глоба on 4/9/26.
//

import UIKit

final class CurrencyPairScreenViewController: UIViewController {
    private let contentView: CurrencyPairScreenView

    private let presenter: CurrencyPairScreenPresenter

    init(presenter: CurrencyPairScreenPresenter) {
        let contentView = CurrencyPairScreenView()
        self.contentView = contentView
        self.presenter = presenter
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
        
        presenter.view = contentView
        contentView.presenter = presenter
        
        contentView.setupCollectionView()
        
        contentView.updatePair(
            base: presenter.pair.base.currency,
            counter: presenter.pair.counter.currency,
            rate: String(format: "%.4f", presenter.rate),
            selectedSlot: nil
        )

        contentView.updateCurrencyList(
            presenter.getAvailableCurrencies(),
            showEmptyFavoritesPlaceholder: false
        )
    }
}
