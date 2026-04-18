//
//  CurrencyFullListViewController.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

protocol CurrencyPickerListRefresh: AnyObject {
    func refreshDisplayedCurrencies()
}

final class CurrencyFullListViewController: UIViewController {
    
    private let presenter: CurrencyPairScreenPresenter
    private let favoriteFilterView = CurrencyPairScreenFavoriteView()
    private let filterSegmentedControl = UISegmentedControl(items: ["Все", "Фиат", "Крипта"])
    private let collectionView = CurrencyPairCollectionView()
    
    private var favoritesOnly = false
    
    init(presenter: CurrencyPairScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.listRefreshHandler = self
        favoriteFilterView.delegate = self
        
        refreshDisplayedCurrencies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            presenter.listRefreshHandler = nil
            presenter.clearSlotSelection()
        }
    }
}

private extension CurrencyFullListViewController {
    func setupUI() {
        view.backgroundColor = Theme.colorDesignSystem.green
        addSubviews()
        setupSegmentControl()
        setupCollectionView()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(filterSegmentedControl)
        view.addSubview(collectionView)
        view.addSubview(favoriteFilterView)
    }
    
    func setupSegmentControl() {
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
    }
    
    func setupCollectionView() {
        collectionView.presenter = presenter
    }
    
    func setupConstraints() {
        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        favoriteFilterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            favoriteFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            favoriteFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            filterSegmentedControl.topAnchor.constraint(equalTo: favoriteFilterView.bottomAnchor, constant: 12),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            collectionView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func filterChanged() {
        let filter: CurrencyType?
        switch filterSegmentedControl.selectedSegmentIndex {
        case 1: filter = .fiat
        case 2: filter = .crypto
        default: filter = nil
        }
        presenter.applyCurrencyFilter(filter)
        refreshDisplayedCurrencies()
    }
}

extension CurrencyFullListViewController: CurrencyPickerListRefresh {
    func refreshDisplayedCurrencies() {
        let list = presenter.getAvailableCurrencies()
        let showEmpty = favoritesOnly && list.isEmpty
        collectionView.configure(with: list, showEmptyFavoritesPlaceholder: showEmpty)
    }
}

extension CurrencyFullListViewController: CurrencyPairScreenFavoriteViewDelegate {
    func favoriteFilterView(_ view: CurrencyPairScreenFavoriteView, didChangeFilterState: Bool) {
        favoritesOnly = didChangeFilterState
        presenter.showOnlyFavorites(didChangeFilterState)
        refreshDisplayedCurrencies()
    }
}


