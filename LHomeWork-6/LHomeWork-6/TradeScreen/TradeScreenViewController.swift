//
//  TradeScreenViewController.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
//

import UIKit

final class TradeScreenViewController: UIViewController {

    private let contentView = TradeScreenView()
    private let presenter: TradeScreenPresenterProtocol
    
    init(presenter: TradeScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.colorDesignSystem.orange
        action()
    }

    func action() {
        contentView.onRunTap = { [weak self] in
            self?.presenter.didTapRunButton()
        }
        presenter.didLoad()
    }
}

extension TradeScreenViewController: TradeScreenViewProtocol {
    func showSteps(_ steps: [TradeStep]) {
        contentView.updateTableView(with: steps)
    }
    
    func setSimulationStarted(_ started: Bool) {
        contentView.setSimulationStarted(started)
    }
}
