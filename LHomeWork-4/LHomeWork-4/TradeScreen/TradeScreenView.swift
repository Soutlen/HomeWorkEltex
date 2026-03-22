//
//  TradeScreenView.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import UIKit

final class TradeScreenView: UIView {
    private let scrollView = ScrollView()
    private let titleLabel = UILabel()
    private let userNameLabel = UILabel()
    private let imageViewAvatar = UIImageView()
    private let stackViewHorizontalUser = UIStackView()
    private let buttomRun = Button()
    
    var infoLabel = UILabel()
    var onTouchHandler: (() -> Void)? = nil
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Theme.color.orange
        add()
        setupLabel()
        setupStackView()
        setupImage()
        setupButton()
        setupConstraints()
    }
    
    private func add() {
        self.addSubview(scrollView)
        self.addSubview(buttomRun)
        
        scrollView.add(titleLabel)
        scrollView.add(stackViewHorizontalUser)
        scrollView.add(infoLabel)
        
        stackViewHorizontalUser.addArrangedSubview(userNameLabel)
        stackViewHorizontalUser.addArrangedSubview(imageViewAvatar)
    }
    
    private func setupLabel() {
        titleLabel.text = "Crypto Wallet"
        titleLabel.textColor = Theme.color.white
        titleLabel.textAlignment = .center
        titleLabel.font = Theme.font.bold(size: 24)
  
        userNameLabel.text = "User Name"
        userNameLabel.textColor = Theme.color.white
        userNameLabel.textAlignment = .center
        userNameLabel.font = Theme.font.regular(size: 24)
        
        infoLabel.text = "Tap button for start simulation"
        infoLabel.textColor = Theme.color.white
        infoLabel.textAlignment = .left
        infoLabel.font = Theme.font.regular(size: 18)
        infoLabel.numberOfLines = 0
    }
    
    private func setupStackView() {
        stackViewHorizontalUser.axis = .horizontal
        stackViewHorizontalUser.spacing = 16
        stackViewHorizontalUser.alignment = .center
        stackViewHorizontalUser.distribution = .equalSpacing
    }
    
    private func setupImage() {
        imageViewAvatar.image = UIImage(systemName: "person.fill")
        imageViewAvatar.contentMode = .scaleAspectFit
        imageViewAvatar.translatesAutoresizingMaskIntoConstraints = false
        imageViewAvatar.layer.cornerRadius = Theme.size.CornerRadius.s
    }
    
    private func setupButton() {
        buttomRun.setTitle("Run", for: .normal)
        buttomRun.addTarget(
            self,
            action: #selector(onTouchDown),
            for: .touchUpInside
        )
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewHorizontalUser.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        buttomRun.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.content.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.content.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.content.trailingAnchor, constant: -16),
            
            stackViewHorizontalUser.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackViewHorizontalUser.leadingAnchor.constraint(equalTo: scrollView.content.leadingAnchor, constant: 16),
            stackViewHorizontalUser.trailingAnchor.constraint(equalTo: scrollView.content.trailingAnchor, constant: -16),
            
            infoLabel.topAnchor.constraint(equalTo: stackViewHorizontalUser.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: scrollView.content.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: scrollView.content.trailingAnchor, constant: -16),
            
            buttomRun.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttomRun.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttomRun.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            buttomRun.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    private func onTouchDown() {
        print("Tap")
        self.onTouchHandler?()
    }
}

