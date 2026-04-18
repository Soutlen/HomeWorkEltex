//
//  TradeSimulationUseCase.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

protocol TradeSimulationUseCaseProtocol {
    func execute() -> [TradeStep]
}

final class TradeSimulationUseCase {
    private let bot: TradingСurrencyBotProtocol
    private let iteration: Int
    
    init(bot: TradingСurrencyBotProtocol, iteration: Int) {
        self.bot = bot
        self.iteration = iteration
    }
}

extension TradeSimulationUseCase: TradeSimulationUseCaseProtocol {
    func execute() -> [TradeStep] {
        bot.runSimulationTrading(iteration: iteration)
    }
}
