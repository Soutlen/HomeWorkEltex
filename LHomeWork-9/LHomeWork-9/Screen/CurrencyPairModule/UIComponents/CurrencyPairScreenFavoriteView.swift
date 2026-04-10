//
//  CurrencyPairScreenFavoriteView.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import UIKit

protocol CurrencyPairScreenFavoriteViewDelegate: AnyObject {
    func favoriteFilterView(_ view: CurrencyPairScreenFavoriteView, didChangeFilterState: Bool)
}

final class CurrencyPairScreenFavoriteView: UIView {
    weak var delegate: CurrencyPairScreenFavoriteViewDelegate?
    
    private let titleLabel = UILabel()
    private let switchControl = UISwitch()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CurrencyPairScreenFavoriteView {
    func setupUI() {
        setupAddSubviews()
        setupLabel()
        setupSwitchControl()
        setupStackView()
        setupConstraints()
    }
    
    func setupAddSubviews() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(switchControl)
    }
    
    func setupLabel() {
        titleLabel.text = "Фильтр по избранному"
        titleLabel.font = Theme.fontDesignSystem.medium(size: 16)
        titleLabel.textColor = Theme.colorDesignSystem.black
    }
    
    func setupSwitchControl() {
        switchControl.addTarget(
            self,
            action: #selector(switchValueChanged),
            for: .valueChanged
        )
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc
    func switchValueChanged() {
        delegate?.favoriteFilterView(self, didChangeFilterState: switchControl.isOn)
    }
}
