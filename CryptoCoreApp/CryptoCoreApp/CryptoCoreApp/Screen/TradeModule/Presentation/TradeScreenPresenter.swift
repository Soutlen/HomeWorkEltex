//
//  TradeScreenPresenter.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

protocol TradeScreenPresenterProtocol: AnyObject {
    func didLoad()
    func didTapRunButton()
}

final class TradeScreenPresenter {
    weak var view: TradeScreenViewProtocol?
    private let useCase: TradeSimulationUseCaseProtocol
    
    init(useCase: TradeSimulationUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension TradeScreenPresenter: TradeScreenPresenterProtocol {
    func didLoad() {
        view?.setSimulationStarted(false)
    }
    
    func didTapRunButton() {
        view?.setSimulationStarted(true)
        let steps = useCase.execute()
        view?.showSteps(steps)
    }
}

