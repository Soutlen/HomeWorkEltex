//
//  CurrencyPairScreenPresenter.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

protocol CurrencyPairScreenPresenterInput: AnyObject {
    func selectSlot(_ slot: CurrencyPairSlot)
    func chooseCurrency(_ currency: CurrencyModel)
    func getAvailableCurrencies() -> [CurrencyModel]
    func applyCurrencyFilter(_ filter: CurrencyType?)
    func showOnlyFavorites(_ only: Bool)
    func toggleFavorite(for currencyCode: String)
    
    func popularCurrencies(limit: Int) -> [CurrencyModel]
    func clearSlotSelection()
    func resetTradingToInitial()
    func randomizePairAndActivateTrading()
}

final class CurrencyPairScreenPresenter {
    
    weak var view: CurrencyPairScreenViewInput?
    weak var listRefreshHandler: CurrencyPickerListRefresh?
    
    private(set) var pair: CurrencyPair
    private let initialPair: CurrencyPair
    private var currencies: [CurrencyModel] = []
    private var selectedSlot: CurrencyPairSlot?
    private var currencyFilter: CurrencyType?
    private var isShowingOnlyFavorites = false

    init(currencies: [CurrencyModel]) {
        self.currencies = currencies
        
        if currencies.count >= 2 {
            self.pair = CurrencyPair(base: currencies[0], counter: currencies[1])
        } else {
            let dummyType: CurrencyType = .crypto
            let dummy = CurrencyModel(currency: "USD", type: dummyType, isFavorite: false)
            self.pair = CurrencyPair(base: dummy, counter: dummy)
        }
        
        self.initialPair = pair
    }

    private func refreshPickerList() {
        listRefreshHandler?.refreshDisplayedCurrencies()
    }
}

extension CurrencyPairScreenPresenter: CurrencyPairScreenPresenterInput {
    func selectSlot(_ slot: CurrencyPairSlot) {
        selectedSlot = slot
        refreshPickerList()
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

        view?.updatePair(
            base: pair.base.currency,
            counter: pair.counter.currency
        )
        view?.updateTradingState(.empty)
        refreshPickerList()
    }
    
    func getAvailableCurrencies() -> [CurrencyModel] {
        guard let slot = selectedSlot else { return [] }
        
        let alreadyUsed = slot == .base ? pair.base : pair.counter
        
        var baseList = currencies.filter { $0 != alreadyUsed }
        
        if let filter = currencyFilter {
            baseList = baseList.filter { $0.type == filter }
        }
        
        if isShowingOnlyFavorites {
            baseList = baseList.filter { $0.isFavorite }
        }
        
        return baseList
    }
    
    func applyCurrencyFilter(_ filter: CurrencyType?) {
        currencyFilter = filter
        refreshPickerList()
    }
    
    func showOnlyFavorites(_ only: Bool) {
        isShowingOnlyFavorites = only
        refreshPickerList()
    }
    
    func toggleFavorite(for currencyCode: String) {
        guard let index = currencies.firstIndex(where: { $0.currency == currencyCode }) else { return }
        currencies[index].isFavorite.toggle()
        
        let updated = currencies[index]
        
        if pair.base.currency == currencyCode {
            pair = CurrencyPair(base: updated, counter: pair.counter)
        }
        if pair.counter.currency == currencyCode {
            pair = CurrencyPair(base: pair.base, counter: updated)
        }
        refreshPickerList()
    }
    
    func popularCurrencies(limit: Int) -> [CurrencyModel] {
        let available = getAvailableCurrencies()
        guard !available.isEmpty else { return [] }
        let favorites = available.filter(\.isFavorite)
        var result: [CurrencyModel] = []
        var seen = Set<String>()
        for c in favorites.shuffled() where result.count < limit {
            if seen.insert(c.currency).inserted {
                result.append(c)
            }
        }
        if result.count < limit {
            for c in available.shuffled() where result.count < limit {
                if seen.insert(c.currency).inserted {
                    result.append(c)
                }
            }
        }
        return result
    }
    
    func clearSlotSelection() {
        selectedSlot = nil
        refreshPickerList()
    }
    
    func resetTradingToInitial() {
        pair = initialPair
        selectedSlot = nil
        view?.updatePair(base: pair.base.currency, counter: pair.counter.currency)
        view?.updateTradingState(.empty)
        refreshPickerList()
    }
    
    func randomizePairAndActivateTrading() {
        guard currencies.count >= 2 else { return }
        var indices = Array(currencies.indices)
        let i = indices.remove(at: Int.random(in: 0..<indices.count))
        let j = indices.randomElement()!
        pair = CurrencyPair(base: currencies[i], counter: currencies[j])
        let rate = Double.random(in: 0.1...1000)
        selectedSlot = nil
        view?.updatePair(base: pair.base.currency, counter: pair.counter.currency)
        view?.updateTradingState(.active(rate: rate))
        refreshPickerList()
    }
}

