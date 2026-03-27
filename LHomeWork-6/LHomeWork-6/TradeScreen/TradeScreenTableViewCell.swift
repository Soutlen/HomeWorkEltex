//
//  TradeScreenTableViewCell.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

final class TradeScreenTableViewCell: UITableViewCell {

    static let reuseIdentifier = "TradeScreenTableViewCell"

    private let topView = UIView()
    private let topLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(primaryText: String, action: TradeAction) {
        topLabel.text = primaryText

        switch action {
        case .buy:
            topView.backgroundColor = Theme.color.green
        case .sell:
            topView.backgroundColor = Theme.color.red
        case .hold:
            topView.backgroundColor = Theme.color.orange
        }
    }
}

private extension TradeScreenTableViewCell {
    func setupUI() {
        contentView.backgroundColor = .clear
        addSubviews()
        setupLabels()
        setupConstraints()
    }

    func addSubviews() {
        contentView.addSubview(topView)

        topView.addSubview(topLabel)
    }

    func setupLabels() {
        topLabel.textColor = Theme.color.black
        topLabel.font = Theme.font.regular(size: 18)
        topLabel.numberOfLines = 0
    }

    func setupConstraints() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            topLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            topLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
    }
}
