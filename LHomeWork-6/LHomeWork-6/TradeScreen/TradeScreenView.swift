//
//  TradeScreenView.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

protocol TradeScreenViewProtocol: AnyObject {
    func showSteps(_ steps: [TradeStep])
    func setSimulationStarted(_ isStarted: Bool)
}

final class TradeScreenView: UIView {
    private let titleLabel = UILabel()
    private let infoDataLabel = UILabel()
    private let imageViewAvatar = UIImageView()
    private let userNameLabel = UILabel()
    private let stackViewHorizontalUser = UIStackView()
    private let buttomRun = ActionButton()
    private let tableView = UITableView()
    
    private let dataSource = TradeScreenTableViewDataSource()

    var onRunTap: (() -> Void)? = nil
    
    private var isSimulationStarted = false

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTableView(with steps: [TradeStep]) {
        dataSource.updateData(steps)
        tableView.reloadData()
    }
    
    func setSimulationStarted(_ started: Bool) {
        isSimulationStarted = started
        infoDataLabel.isHidden = started
        tableView.isHidden = !started
    }
}

//MARK: - UI
private extension TradeScreenView {
    func setupUI() {
        backgroundColor = Theme.colorDesignSystem.orange
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
        self.addSubview(infoDataLabel)
        self.addSubview(tableView)
        self.addSubview(stackViewHorizontalUser)
        self.addSubview(buttomRun)

        stackViewHorizontalUser.addArrangedSubview(imageViewAvatar)
        stackViewHorizontalUser.addArrangedSubview(userNameLabel)
    }

    func setupLabel() {
        titleLabel.text = "Crypto Wallet"
        titleLabel.textColor = Theme.colorDesignSystem.white
        titleLabel.textAlignment = .center
        titleLabel.font = Theme.fontDesignSystem.bold(size: 24)

        userNameLabel.text = "User Name"
        userNameLabel.textColor = Theme.colorDesignSystem.white
        userNameLabel.textAlignment = .center
        userNameLabel.font = Theme.fontDesignSystem.regular(size: 24)

        infoDataLabel.text = "No Data"
        infoDataLabel.textColor = Theme.colorDesignSystem.white
        infoDataLabel.textAlignment = .center
        infoDataLabel.font = Theme.fontDesignSystem.regular(size: 24)
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
        imageViewAvatar.layer.cornerRadius = Theme.sizeDesignSystem.CornerRadius.small
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
        tableView.isHidden = true
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

            infoDataLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            infoDataLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoDataLabel.heightAnchor.constraint(equalToConstant: 50),

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
        self.onRunTap?()
    }
}
