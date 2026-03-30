//
//  ScrollView.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

protocol ScrollViewProtocol: AnyObject {
    func add(_ view: UIView)
}

final class ScrollView: UIScrollView {
   
    let content = UIView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension ScrollView {
    private func setupUI() {
        alwaysBounceVertical = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
            content.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor)
        ])
    }
}

extension ScrollView: ScrollViewProtocol {
    func add(_ view: UIView) {
        content.addSubview(view)
    }
}

