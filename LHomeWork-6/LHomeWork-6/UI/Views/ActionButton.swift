//
//  Button.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

final class ActionButton: UIButton {
    
    enum Mode {
        enum Normal {
            static let backgroundColor = Theme.colorDesignSystem.black
            static let titleColor = Theme.colorDesignSystem.white
        }
        
        enum Disable {
            static let background = Theme.colorDesignSystem.red
            static let titleColor = Theme.colorDesignSystem.white
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Mode.Normal.backgroundColor
        setTitleColor(Mode.Normal.titleColor, for: .normal)
        titleLabel?.font = Theme.fontDesignSystem.regular(size: 18)
        titleLabel?.textColor = Theme.colorDesignSystem.white
        titleLabel?.textAlignment = .center
        layer.cornerRadius = Theme.sizeDesignSystem.CornerRadius.medium
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
