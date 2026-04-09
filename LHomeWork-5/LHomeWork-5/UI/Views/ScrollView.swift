//
//  ScrollView.swift
//  LHomeWork-5
//
//  Created by Евгений Глоба on 3/23/26.
//

import UIKit

protocol ScrollViewProtocol: AnyObject {
    func add(_ view: UIView)
}

final class ScrollView: UIScrollView, ScrollViewProtocol {
    let content = UIView()
    
    override var contentSize: CGSize {
        didSet {
            content.frame = CGRect(
                x: 0,
                y: 0,
                width: contentSize.width,
                height: contentSize.height
            )
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(_ view: UIView) {
        content.addSubview(view)
    }
    
    private func setupUI() {
        alwaysBounceVertical = true
        addSubview(content)
    }
}
