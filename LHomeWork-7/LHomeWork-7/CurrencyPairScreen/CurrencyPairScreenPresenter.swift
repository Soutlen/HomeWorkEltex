//
//  CurrencyPairScreenPresenter.swift
//  LHomeWork-7
//
//  Created by Евгений Глоба on 4/5/26.
//

import Foundation

protocol CurrencyPairScreenPresenterInput: AnyObject {
    func selectSlot(_ slot: CurrencyPairSlot)
    func chooseCurrency(_ currency: CurrencyModel)
    func getAvailableCurrencies() -> [CurrencyModel]
    func applyCurrencyFilter(_ filter: CurrencyType?)
}

final class CurrencyPairScreenPresenter {
    
    weak var view: CurrencyPairScreenViewInput?
    
    private(set) var pair: CurrencyPair
    private var currencies: [CurrencyModel] = []
    private var selectedSlot: CurrencyPairSlot? = nil
    var rate: Double = 1.0
    
    private var currencyFilter: CurrencyType? = nil

    init(currencies: [CurrencyModel]) {
        self.currencies = currencies
        
        if currencies.count >= 2 {
            self.pair = CurrencyPair(base: currencies[0], counter: currencies[1])
        } else {
            let dummyType: CurrencyType = .crypto
            let dummy = CurrencyModel(currency: "USD", type: dummyType)
            self.pair = CurrencyPair(base: dummy, counter: dummy)
        }
        
        self.rate = .random(in: 0.1...1000)
    }
}

extension CurrencyPairScreenPresenter: CurrencyPairScreenPresenterInput {
    func selectSlot(_ slot: CurrencyPairSlot) {
        selectedSlot = slot
        view?.updateCurrencyList(getAvailableCurrencies())
        view?.updatePair(
            base: pair.base.currency,
            counter: pair.counter.currency,
            rate: String(format: "%.4f", rate),
            selectedSlot: selectedSlot
        )
    }
    
    func chooseCurrency(_ currency: CurrencyModel) {
        guard let slot = selectedSlot else { return }

        switch slot {
        case .base:
            if pair.counter.currency == currency.currency { return }
            pair = CurrencyPair(base: currency, counter: pair.counter)
        case .counter:
            if pair.base.currency == currency.currency { return }
            pair = CurrencyPair(base: pair.base, counter: currency)
        }

        rate = .random(in: 0.1...1000)
        selectedSlot = nil

        view?.updatePair(
            base: pair.base.currency,
            counter: pair.counter.currency,
            rate: String(format: "%.4f", rate),
            selectedSlot: selectedSlot
        )
        view?.updateCurrencyList(getAvailableCurrencies())
    }
    
    func getAvailableCurrencies() -> [CurrencyModel] {
        guard let slot = selectedSlot else { return [] }
        let alreadyUsed = slot == .base ? pair.base : pair.counter
        var baseList = currencies.filter { $0 != alreadyUsed }
        
        if let filter = currencyFilter {
            baseList = baseList.filter { $0.type == filter }
        }
        
        return baseList
    }
    
    func applyCurrencyFilter(_ filter: CurrencyType?) {
        currencyFilter = filter
        view?.updateCurrencyList(getAvailableCurrencies())
    }
}
