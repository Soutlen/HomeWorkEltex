//
//  Button.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import UIKit

final class Button: UIButton {
    
    enum Mode {
        enum Normal {
            static let backgroundColor = Theme.color.black
            static let titleColor = Theme.color.white
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
        titleLabel?.font = Theme.font.regular(size: 18)
        titleLabel?.textColor = Theme.color.white
        titleLabel?.textAlignment = .center
        layer.cornerRadius = Theme.size.CornerRadius.m
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
