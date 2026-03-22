//
//  TradeScreenViewController.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import UIKit

final class TradeScreenViewController: UIViewController  {

    private let contentView = TradeScreenView()
    private let presenter = TradeScreenPresenter()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        action()
    }
    
    func action() {
        contentView.onTouchHandler = { [weak self] in
            self?.presenter.buttonTapped()
        }
    }
}

extension TradeScreenViewController: TradeScreenPresenterProtocol {
    func showText(_ text: [String]) {
        contentView.infoLabel.text = text.joined(separator: "\n")
    }
}


