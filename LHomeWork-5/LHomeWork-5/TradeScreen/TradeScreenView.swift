//
//  TradeScreenView.swift
//  LHomeWork-5
//
//  Created by Евгений Глоба on 3/23/26.
//

import UIKit

struct LayoutParams {
    let padding: CGFloat = 16
    let topSpacing: CGFloat = 20
    let buttonHeight: CGFloat = 60
    let buttonBottom: CGFloat = 50
    let avatarSize: CGFloat = 32
}

final class TradeScreenView: UIView {
    private let scrollView = ScrollView()
    private let titleLabel = UILabel()
    private let userNameLabel = UILabel()
    private let imageViewAvatar = UIImageView()
    private let infoDataLabel = UILabel()
    private let stackViewHorizontalUser = UIStackView()
    private let buttomRun = Button()
    private var isSimulationStarted = false
    
    var tradeInfoLabel = UILabel()
    var onTouchHandler: (() -> Void)? = nil
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layoutParams = LayoutParams()
        
        layoutContainer(layoutParams)
        layoutScrollView(layoutParams)
        layoutContent(layoutParams)
        layoutButton(layoutParams)
    }
}

private extension TradeScreenView {
    func setupUI() {
        backgroundColor = Theme.color.orange
        add()
        setupLabel()
        setupStackView()
        setupImage()
        setupButton()
    }
    
    func add() {
        self.addSubview(scrollView)
        self.addSubview(buttomRun)
        
        scrollView.add(titleLabel)
        scrollView.add(stackViewHorizontalUser)
        scrollView.add(tradeInfoLabel)
        scrollView.add(infoDataLabel)
        
        stackViewHorizontalUser.addArrangedSubview(userNameLabel)
        stackViewHorizontalUser.addArrangedSubview(imageViewAvatar)
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
    
            tradeInfoLabel.textColor = Theme.color.white
            tradeInfoLabel.textAlignment = .left
            tradeInfoLabel.font = Theme.font.regular(size: 18)
            tradeInfoLabel.numberOfLines = 0
            tradeInfoLabel.isHidden = true
    
            infoDataLabel.text = "No Data"
            infoDataLabel.textColor = Theme.color.white
            infoDataLabel.textAlignment = .center
            infoDataLabel.font = Theme.font.regular(size: 24)
            infoDataLabel.numberOfLines = 1
            infoDataLabel.isHidden = false
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
        imageViewAvatar.layer.cornerRadius = Theme.size.CornerRadius.s
        imageViewAvatar.clipsToBounds = true
    }
    
    func setupButton() {
        buttomRun.setTitle("Run", for: .normal)
        buttomRun.addTarget(
            self,
            action: #selector(onTouchDown),
            for: .touchUpInside
        )
    }
    
    func layoutContainer(_ params: LayoutParams) {
        let safe = safeAreaInsets
        scrollView.frame = CGRect(
            x: 0,
            y: safe.top,
            width: bounds.width,
            height: bounds.height - safe.top - safe.bottom
        )
    }
    
    func layoutButton(_ params: LayoutParams) {
        let safe = safeAreaInsets
        buttomRun.frame = CGRect(
            x: params.padding,
            y: bounds.height - safe.bottom - params.buttonBottom - params.buttonHeight,
            width: bounds.width - params.padding * 2,
            height: params.buttonHeight
        )
    }
    
    func layoutScrollView(_ params: LayoutParams) {
        let contentWidth = scrollView.bounds.width
        scrollView.contentSize = CGSize(
            width: contentWidth,
            height: calculateContentHeight(contentWidth: contentWidth, params: params)
        )
    }
    
    func layoutContent(_ params: LayoutParams) {
        let contentWidth = scrollView.bounds.width
        var currentY: CGFloat = params.topSpacing
        
        currentY = layoutTitleLabel(contentWidth: contentWidth, currentY: currentY, params: params)
        currentY = layoutUserInfo(contentWidth: contentWidth, currentY: currentY, params: params)
        
        _ = layoutInfoLabels(contentWidth: contentWidth, currentY: currentY, params: params)
    }
    
    func layoutTitleLabel(contentWidth: CGFloat, currentY: CGFloat, params: LayoutParams) -> CGFloat {
        let titleHeight = titleLabel.sizeThatFits(
            CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)
        ).height
        
        titleLabel.frame = CGRect(
            x: params.padding,
            y: currentY,
            width: contentWidth - params.padding * 2,
            height: titleHeight
        )
        
        return titleLabel.frame.maxY + params.topSpacing
    }
    
    func layoutUserInfo(contentWidth: CGFloat, currentY: CGFloat, params: LayoutParams) -> CGFloat {
        let userNameSize = userNameLabel.sizeThatFits(
            CGSize(width: contentWidth - params.padding * 2 - params.avatarSize - 16, height: .greatestFiniteMagnitude)
        )
        let stackHeight = max(userNameSize.height, params.avatarSize)
        
        stackViewHorizontalUser.frame = CGRect(
            x: params.padding,
            y: currentY,
            width: contentWidth - params.padding * 2,
            height: stackHeight
        )
        
        userNameLabel.frame = CGRect(
            x: 0,
            y: (stackHeight - userNameSize.height) / 2,
            width: userNameSize.width,
            height: userNameSize.height
        )
        
        imageViewAvatar.frame = CGRect(
            x: userNameLabel.frame.maxX + 16,
            y: (stackHeight - params.avatarSize) / 2,
            width: params.avatarSize,
            height: params.avatarSize
        )
        
        return stackViewHorizontalUser.frame.maxY + params.topSpacing
    }
    
    func layoutInfoLabels(contentWidth: CGFloat, currentY: CGFloat, params: LayoutParams) -> CGFloat {
        if isSimulationStarted {
            let infoHeight = tradeInfoLabel.sizeThatFits(
                CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)
            ).height
            
            tradeInfoLabel.frame = CGRect(
                x: params.padding,
                y: currentY,
                width: contentWidth - params.padding * 2,
                height: infoHeight
            )
            
            infoDataLabel.frame = .zero
            return tradeInfoLabel.frame.maxY + params.topSpacing
        } else {
            let infoHeight = infoDataLabel.sizeThatFits(
                CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)
            ).height
            
            infoDataLabel.frame = CGRect(
                x: params.padding,
                y: currentY,
                width: contentWidth - params.padding * 2,
                height: infoHeight
            )
            
            tradeInfoLabel.frame = .zero
            return infoDataLabel.frame.maxY + params.topSpacing
        }
    }
    
    func calculateContentHeight(contentWidth: CGFloat, params: LayoutParams) -> CGFloat {
        let titleHeight = titleLabel.sizeThatFits(
            CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)
        ).height
        
        let userNameSize = userNameLabel.sizeThatFits(
            CGSize(width: contentWidth - params.padding * 2 - params.avatarSize - 16, height: .greatestFiniteMagnitude)
        )
        let stackHeight = max(userNameSize.height, params.avatarSize)
        
        let currentY = params.topSpacing
        let afterTitle = currentY + titleHeight + params.topSpacing
        let afterStack = afterTitle + stackHeight + params.topSpacing
        let infoHeight = isSimulationStarted ?
        tradeInfoLabel.sizeThatFits(CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)).height :
        infoDataLabel.sizeThatFits(CGSize(width: contentWidth - params.padding * 2, height: .greatestFiniteMagnitude)).height
        
        return afterStack + infoHeight + params.topSpacing
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
            tradeInfoLabel.isHidden = false
        }
        
        setNeedsLayout()
    }
}
