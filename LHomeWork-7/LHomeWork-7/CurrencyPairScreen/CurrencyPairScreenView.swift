//
//  CurrencyPairScreenView.swift
//  LHomeWork-7
//
//  Created by Евгений Глоба on 4/5/26.
//

import UIKit

protocol CurrencyPairScreenViewInput: AnyObject {
    func updatePair(
        base: String,
        counter: String,
        rate: String,
        selectedSlot: CurrencyPairSlot?
    )
    func updateCurrencyList(_ currencies: [CurrencyModel])
}

final class CurrencyPairScreenView: UIView {
    weak var presenter: CurrencyPairScreenPresenterInput?

    private let baseLabel = UILabel()
    private let counterLabel = UILabel()
    private let rateLabel = UILabel()
    private let stackViewTitle = UIStackView()
    private let collectionView = CurrencyPairCollectionView()
    
    private(set) var selectedSlot: CurrencyPairSlot? = nil
    private(set) var currencyFilter: CurrencyType? = nil
    
    private let filterSegmentedControl = UISegmentedControl(
           items: ["Все", "Фиат", "Крипта"]
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.colorDesignSystem.green
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.presenter = presenter
    }
}

private extension CurrencyPairScreenView {
    func setupUI() {
        addSubviews()
        setupStackView()
        setupLabels()
        setupCollectionView()
        setupSegmentedControl()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(stackViewTitle)
        addSubview(filterSegmentedControl)
        addSubview(collectionView)
        stackViewTitle.addArrangedSubview(baseLabel)
        stackViewTitle.addArrangedSubview(counterLabel)
        stackViewTitle.addArrangedSubview(rateLabel)
    }

    func setupStackView() {
        stackViewTitle.axis = .horizontal
        stackViewTitle.spacing = 16
        stackViewTitle.alignment = .center
        stackViewTitle.distribution = .equalSpacing
    }

    func setupLabels() {
        baseLabel.textColor = Theme.colorDesignSystem.white
        baseLabel.textAlignment = .center
        baseLabel.font = Theme.fontDesignSystem.regular(size: 24)
        baseLabel.numberOfLines = 1
        baseLabel.isUserInteractionEnabled = true
        baseLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(baseTapped)))

        counterLabel.textColor = Theme.colorDesignSystem.white
        counterLabel.textAlignment = .center
        counterLabel.font = Theme.fontDesignSystem.regular(size: 24)
        counterLabel.numberOfLines = 1
        counterLabel.isUserInteractionEnabled = true
        counterLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(counterTapped)))

        rateLabel.textColor = Theme.colorDesignSystem.white
        rateLabel.textAlignment = .center
        rateLabel.font = Theme.fontDesignSystem.regular(size: 20)
        rateLabel.numberOfLines = 1
    }

    func setupConstraints() {
        stackViewTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackViewTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackViewTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stackViewTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            filterSegmentedControl.topAnchor.constraint(equalTo: stackViewTitle.bottomAnchor, constant: 12),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            collectionView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc func baseTapped() {
        presenter?.selectSlot(.base)
    }

    @objc func counterTapped() {
        presenter?.selectSlot(.counter)
    }
    
    func applySlotHighlight() {
        let baseHighlighted = selectedSlot == .base
        let counterHighlighted = selectedSlot == .counter
        
        baseLabel.backgroundColor = baseHighlighted ? .systemBlue.withAlphaComponent(0.2) : .clear
        counterLabel.backgroundColor = counterHighlighted ? .systemBlue.withAlphaComponent(0.2) : .clear
    }
    
    func setupSegmentedControl() {
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.addTarget(
            self,
            action: #selector(filterChanged),
            for: .valueChanged
        )
    }
    
    @objc func filterChanged() {
        let index = filterSegmentedControl.selectedSegmentIndex
        
        let filter: CurrencyType?
        switch index {
        case 0: filter = nil
        case 1: filter = .fiat
        case 2: filter = .crypto
        default: filter = nil
        }
        
        self.currencyFilter = filter
        presenter?.applyCurrencyFilter(filter)
    }
}

extension CurrencyPairScreenView: CurrencyPairScreenViewInput {
    func updatePair(base: String, counter: String, rate: String, selectedSlot: CurrencyPairSlot?) {
        self.selectedSlot = selectedSlot
        
        baseLabel.text = base
        counterLabel.text = counter
        rateLabel.text = rate
        
        applySlotHighlight()
    }
    
    func updateCurrencyList(_ currencies: [CurrencyModel]) {
        collectionView.configure(with: currencies)
        applySlotHighlight()
    }
}
