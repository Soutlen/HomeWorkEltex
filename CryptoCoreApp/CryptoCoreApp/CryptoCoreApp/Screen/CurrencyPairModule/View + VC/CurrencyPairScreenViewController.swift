//
//  CurrencyPairScreenViewController.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CurrencyPairScreenViewController: UIViewController {

    private let contentView: CurrencyPairScreenView
    private let presenter: CurrencyPairScreenPresenter
    
    private var skipClearSlotOnSheetDismiss = false

    init(presenter: CurrencyPairScreenPresenter) {
        let contentView = CurrencyPairScreenView()
        self.contentView = contentView
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
        
        title = "Торговля"
        navigationItem.largeTitleDisplayMode = .never
        
        presenter.view = contentView
        contentView.routingDelegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(resetTrading)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "shuffle"),
            style: .plain,
            target: self,
            action: #selector(randomPair)
        )
        
        contentView.updatePair(
            base: presenter.pair.base.currency,
            counter: presenter.pair.counter.currency
        )
        contentView.updateTradingState(.empty)
        setupChartNavigation()
    }
    
    @objc private func resetTrading() {
        presenter.resetTradingToInitial()
    }
    
    @objc private func randomPair() {
        presenter.randomizePairAndActivateTrading()
    }
    
    private func presentShortPicker(for slot: CurrencyPairSlot) {
        presenter.selectSlot(slot)
        let short = CurrencyShortPickerViewController(presenter: presenter, owner: self)
        let nav = UINavigationController(rootViewController: short)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        nav.presentationController?.delegate = self
        present(nav, animated: true)
    }
    func shortPickerRequestsFullList() {
        skipClearSlotOnSheetDismiss = true
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            let full = CurrencyFullListViewController(presenter: self.presenter)
            full.title = "Все валюты"
            self.navigationController?.pushViewController(full, animated: true)
        }
    }
}

extension CurrencyPairScreenViewController: TradingScreenViewDelegate {
    func tradingScreenView(_ view: CurrencyPairScreenView, didRequestCurrencyPickerFor slot: CurrencyPairSlot) {
        presentShortPicker(for: slot)
    }
}

extension CurrencyPairScreenViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if skipClearSlotOnSheetDismiss {
            skipClearSlotOnSheetDismiss = false
        } else {
            presenter.clearSlotSelection()
        }
        presenter.listRefreshHandler = nil
    }
}

private extension CurrencyPairScreenViewController {
    func setupChartNavigation() {
        let chartButton = UIBarButtonItem(
            image: UIImage(systemName: "chart.bar.xaxis"),
            style: .plain,
            target: self,
            action: #selector(openChart)
        )

        navigationItem.rightBarButtonItems = [chartButton, navigationItem.rightBarButtonItem].compactMap { $0 }

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(openChart))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
    }
    
    @objc func openChart() {
        let vc = ChartAssembly.makeChart(
            base: presenter.pair.base.currency,
            counter: presenter.pair.counter.currency
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}
