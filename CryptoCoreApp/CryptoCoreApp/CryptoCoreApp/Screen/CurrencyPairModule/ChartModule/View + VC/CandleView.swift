//
//  CandleView.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CandleView: UIView {
    private let bodyView = UIView()
    private let wickView = UIView()

    private var bodyHeightConstraint: NSLayoutConstraint!
    private var wickHeightConstraint: NSLayoutConstraint!
    private var bodyBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with candle: CandleModel, scale: CGFloat, isSelected: Bool) {
        let color: UIColor = candle.isBullish ? .systemGreen : .systemRed
        bodyView.backgroundColor = color
        wickView.backgroundColor = color

        let bodyHeight = max(CGFloat(abs(candle.closeCandel - candle.openCandel)) * scale, 4)
        let wickHeight = max(CGFloat(candle.highCandel - candle.lowCandel) * scale, bodyHeight + 6)

        bodyHeightConstraint.constant = bodyHeight
        wickHeightConstraint.constant = wickHeight

        bodyBottomConstraint.constant = candle.isBullish ? 8 : 0

        layer.borderWidth = isSelected ? 1 : 0
        layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        layer.cornerRadius = 6
    }
}

private extension CandleView {
    func setupUI() {
        backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(wickView)
        addSubview(bodyView)
    }
    
    func setupConstraints() {
        wickView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        
        bodyHeightConstraint = bodyView.heightAnchor.constraint(equalToConstant: 10)
        wickHeightConstraint = wickView.heightAnchor.constraint(equalToConstant: 20)
        bodyBottomConstraint = bodyView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 30),

            wickView.centerXAnchor.constraint(equalTo: centerXAnchor),
            wickView.widthAnchor.constraint(equalToConstant: 3),
            wickView.bottomAnchor.constraint(equalTo: bottomAnchor),
            wickHeightConstraint,

            bodyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bodyView.widthAnchor.constraint(equalToConstant: 20),
            bodyBottomConstraint,
            bodyHeightConstraint
        ])
    }
}
