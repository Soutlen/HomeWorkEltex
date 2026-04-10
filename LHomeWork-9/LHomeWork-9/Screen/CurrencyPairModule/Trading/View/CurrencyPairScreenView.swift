//
//  CurrencyPairScreenView.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import UIKit

protocol CurrencyPairScreenViewInput: AnyObject {
    func updatePair(base: String, counter: String)
    func updateTradingState(_ state: CurrencyPairScreenDisplayState)
}

protocol TradingScreenViewDelegate: AnyObject {
    func tradingScreenView(
        _ view: CurrencyPairScreenView,
        didRequestCurrencyPickerFor slot: CurrencyPairSlot
    )
}

final class CurrencyPairScreenView: UIView {
    
    weak var presenter: CurrencyPairScreenPresenterInput?
    weak var routingDelegate: TradingScreenViewDelegate?

    private let pairContainer = UIView()
    private let baseLabel = UILabel()
    private let separatorLabel = UILabel()
    private let counterLabel = UILabel()
    private let pairStack = UIStackView()
    
    private let rateTitleLabel = UILabel()
    private let rateValueLabel = UILabel()
    private let resultsTitleLabel = UILabel()
    private let resultsValueLabel = UILabel()
    private let tradingStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.colorDesignSystem.green
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrencyPairScreenView {
    func setupUI() {
        addSubviews()
        setupContainer()
        setupStackView()
        setupLabels()
        styleTradingSection()
        setupConstraints()
    }

    func addSubviews() {
        self.addSubview(pairContainer)
        
        pairContainer.addSubview(pairStack)
        pairStack.addArrangedSubview(baseLabel)
        pairStack.addArrangedSubview(separatorLabel)
        pairStack.addArrangedSubview(counterLabel)
        
        addSubview(tradingStack)
        tradingStack.addArrangedSubview(rateTitleLabel)
        tradingStack.addArrangedSubview(rateValueLabel)
        tradingStack.addArrangedSubview(resultsTitleLabel)
        tradingStack.addArrangedSubview(resultsValueLabel)
    }
    
    func setupContainer() {
        pairContainer.backgroundColor = Theme.colorDesignSystem.orange.withAlphaComponent(0.35)
        pairContainer.layer.cornerRadius = Theme.sizeDesignSystem.CornerRadius.medium
        pairContainer.layer.masksToBounds = true
        pairContainer.isUserInteractionEnabled = true
        
        let blockTap = UITapGestureRecognizer(target: self, action: #selector(pairBlockTapped))
        pairContainer.addGestureRecognizer(blockTap)
    }

    func setupStackView() {
        pairStack.axis = .horizontal
        pairStack.spacing = 12
        pairStack.alignment = .center
        pairStack.distribution = .equalSpacing
    }
    

    func setupLabels() {
        separatorLabel.text = "—"
        separatorLabel.textColor = Theme.colorDesignSystem.white
        separatorLabel.font = Theme.fontDesignSystem.medium(size: 22)
        
        configureCurrencyLabel(baseLabel)
        configureCurrencyLabel(counterLabel)
    }
    
    func configureCurrencyLabel(_ label: UILabel) {
        label.textColor = Theme.colorDesignSystem.white
        label.textAlignment = .center
        label.font = Theme.fontDesignSystem.regular(size: 24)
        label.numberOfLines = 1
        label.isUserInteractionEnabled = false
    }
    
    func styleTradingSection() {
        tradingStack.axis = .vertical
        tradingStack.spacing = 8
        tradingStack.alignment = .fill
        
        rateTitleLabel.text = "Курс"
        rateTitleLabel.textColor = Theme.colorDesignSystem.white.withAlphaComponent(0.85)
        rateTitleLabel.font = Theme.fontDesignSystem.medium(size: 14)
        
        rateValueLabel.textColor = Theme.colorDesignSystem.white
        rateValueLabel.font = Theme.fontDesignSystem.regular(size: 28)
        rateValueLabel.numberOfLines = 1
        
        resultsTitleLabel.text = "Результаты торговли"
        resultsTitleLabel.textColor = Theme.colorDesignSystem.white.withAlphaComponent(0.85)
        resultsTitleLabel.font = Theme.fontDesignSystem.medium(size: 14)
        resultsValueLabel.textColor = Theme.colorDesignSystem.white
        resultsValueLabel.font = Theme.fontDesignSystem.regular(size: 16)
        resultsValueLabel.numberOfLines = 0
    }

    func setupConstraints() {
        pairContainer.translatesAutoresizingMaskIntoConstraints = false
        pairStack.translatesAutoresizingMaskIntoConstraints = false
        tradingStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pairContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            pairContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            pairContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            pairStack.topAnchor.constraint(equalTo: pairContainer.topAnchor, constant: 16),
            pairStack.leadingAnchor.constraint(equalTo: pairContainer.leadingAnchor, constant: 20),
            pairStack.trailingAnchor.constraint(equalTo: pairContainer.trailingAnchor, constant: -20),
            pairStack.bottomAnchor.constraint(equalTo: pairContainer.bottomAnchor, constant: -16),
            
            tradingStack.topAnchor.constraint(equalTo: pairContainer.bottomAnchor, constant: 32),
            tradingStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            tradingStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }

    @objc func pairBlockTapped(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: pairStack)
        guard pairStack.bounds.contains(point) else { return }
        let midX = pairStack.bounds.midX
        let slot: CurrencyPairSlot = point.x < midX ? .base : .counter
        routingDelegate?.tradingScreenView(self, didRequestCurrencyPickerFor: slot)
    }
}

extension CurrencyPairScreenView: CurrencyPairScreenViewInput {
    func updatePair(base: String, counter: String) {
        baseLabel.text = base
        counterLabel.text = counter
    }
    
    func updateTradingState(_ state: CurrencyPairScreenDisplayState) {
        switch state {
        case .empty:
            rateValueLabel.text = "—"
            resultsValueLabel.text = "Нет данных"
        case .active(let rate):
            rateValueLabel.text = String(format: "%.4f", rate)
            resultsValueLabel.text = "Котировка обновлена"
        }
    }
}
