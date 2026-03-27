//
//  TradeScreenViewController.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

final class TradeScreenViewController: UIViewController {

    private let contentView = TradeScreenView()
    private let presenter = TradeScreenPresenter()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        view.backgroundColor = Theme.color.orange
        action()
    }

    func action() {
        contentView.onTouchHandler = { [weak self] in
            self?.presenter.buttonTapped()
        }
    }
}

extension TradeScreenViewController: TradeScreenPresenterProtocol {
    func showStepLog(_ steps: [TradeStep]) {
        contentView.updateTableView(with: steps)
    }
}
