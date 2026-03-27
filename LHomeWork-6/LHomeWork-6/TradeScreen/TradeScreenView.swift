//
//  TradeScreenView.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

final class TradeScreenView: UIView {
    private let titleLabel = UILabel()
    private let infoDataLabel = UILabel()
    private let imageViewAvatar = UIImageView()
    private let userNameLabel = UILabel()
    private let stackViewHorizontalUser = UIStackView()
    private let buttomRun = Button()
    private var isSimulationStarted = false
    private let tableView = UITableView()
    private let dataSource = TradeScreenTableViewDataSource()
    private let delegate = TradeScreenTableViewDelegate()

    var tradeInfoLabel = UILabel()
    var onTouchHandler: (() -> Void)? = nil

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTableView(with steps: [TradeStep]) {
        dataSource.updateData(steps)
        tableView.isHidden = false
        tableView.reloadData()
    }
}

private extension TradeScreenView {
    func setupUI() {
        backgroundColor = Theme.color.orange
        add()
        setupLabel()
        setupButton()
        setupTableView()
        setupStackView()
        setupImage()
        setupConstraints()
    }

    func add() {
        self.addSubview(titleLabel)
        self.addSubview(tradeInfoLabel)
        self.addSubview(infoDataLabel)
        self.addSubview(tableView)
        self.addSubview(stackViewHorizontalUser)
        self.addSubview(buttomRun)

        stackViewHorizontalUser.addArrangedSubview(imageViewAvatar)
        stackViewHorizontalUser.addArrangedSubview(userNameLabel)
    }

    func setupLabel() {
        titleLabel.text = "Crypto Wallet"
        titleLabel.textColor = Theme.color.white
        titleLabel.textAlignment = .center
        titleLabel.font = Theme.font.bold(size: 24)

        userNameLabel.text = "User Name"
        userNameLabel.textColor = Theme.color.white
        userNameLabel.textAlignment = .center
        userNameLabel.font = Theme.font.regular(size: 24)

        infoDataLabel.text = "No Data"
        infoDataLabel.textColor = Theme.color.white
        infoDataLabel.textAlignment = .center
        infoDataLabel.font = Theme.font.regular(size: 24)
        infoDataLabel.numberOfLines = 1
        infoDataLabel.isHidden = false
    }

    func setupButton() {
        buttomRun.setTitle("Run", for: .normal)
        buttomRun.addTarget(
            self,
            action: #selector(onTouchDown),
            for: .touchUpInside
        )
    }

    func setupStackView() {
        stackViewHorizontalUser.axis = .horizontal
        stackViewHorizontalUser.spacing = 16
        stackViewHorizontalUser.alignment = .center
        stackViewHorizontalUser.distribution = .equalSpacing
    }

    func setupImage() {
        imageViewAvatar.image = UIImage(systemName: "person.fill")
        imageViewAvatar.contentMode = .scaleAspectFit
        imageViewAvatar.translatesAutoresizingMaskIntoConstraints = false
        imageViewAvatar.layer.cornerRadius = Theme.size.CornerRadius.s
    }

    func setupTableView() {
        tableView.register(
            TradeScreenTableViewCell.self,
            forCellReuseIdentifier: TradeScreenTableViewCell.reuseIdentifier
        )
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoDataLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontalUser.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buttomRun.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            infoDataLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            stackViewHorizontalUser.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackViewHorizontalUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackViewHorizontalUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: stackViewHorizontalUser.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: buttomRun.topAnchor, constant: -16),

            buttomRun.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttomRun.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttomRun.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            buttomRun.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc
    func onTouchDown() {
        print("Tap")
        toggleLabels()
        self.onTouchHandler?()
    }

    func toggleLabels() {
        if !isSimulationStarted {
            isSimulationStarted = true
            infoDataLabel.isHidden = true
        }
        setNeedsLayout()
    }
}
