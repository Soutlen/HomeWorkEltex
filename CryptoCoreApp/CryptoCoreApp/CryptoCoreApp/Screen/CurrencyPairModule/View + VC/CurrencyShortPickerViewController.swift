//
//  CurrencyShortPickerViewController.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CurrencyShortPickerViewController: UIViewController {
    
    private let presenter: CurrencyPairScreenPresenter
    private weak var owner: CurrencyPairScreenViewController?
    
    private let collectionView = CurrencyPairCollectionView()
    private let allButton = UIButton(type: .system)
    
    init(presenter: CurrencyPairScreenPresenter, owner: CurrencyPairScreenViewController) {
        self.presenter = presenter
        self.owner = owner
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.presenter = presenter
        
        presenter.listRefreshHandler = self
        refreshDisplayedCurrencies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            presenter.listRefreshHandler = nil
        }
    }
}

private extension CurrencyShortPickerViewController {
    func setupUI() {
        view.backgroundColor = Theme.colorDesignSystem.green
        title = "Выбор валюты"
        
        addSubviews()
        setupButton()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(allButton)
    }
    
    func setupButton() {
        allButton.setTitle("Все", for: .normal)
        allButton.titleLabel?.font = Theme.fontDesignSystem.medium(size: 17)
        allButton.addTarget(self, action: #selector(showAllTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        allButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            allButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: allButton.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func showAllTapped() {
        owner?.shortPickerRequestsFullList()
    }
}

extension CurrencyShortPickerViewController: CurrencyPickerListRefresh {
    func refreshDisplayedCurrencies() {
        let items = presenter.popularCurrencies(limit: 10)
        collectionView.configure(with: items, showEmptyFavoritesPlaceholder: false)
    }
}

