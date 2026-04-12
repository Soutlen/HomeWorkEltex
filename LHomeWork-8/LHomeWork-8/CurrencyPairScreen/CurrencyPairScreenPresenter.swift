//
//  CurrencyPairScreenPresenter.swift
//  LHomeWork-8
//
//  Created by Евгений Глоба on 4/9/26.
//

import Foundation

protocol CurrencyPairScreenPresenterInput: AnyObject {
    func selectSlot(_ slot: CurrencyPairSlot)
    func chooseCurrency(_ currency: CurrencyModel)
    func getAvailableCurrencies() -> [CurrencyModel]
    func applyCurrencyFilter(_ filter: CurrencyType?)
    func showOnlyFavorites(_ only: Bool)
    func toggleFavorite(for currencyCode: String)
}

final class CurrencyPairScreenPresenter {
    
    weak var view: CurrencyPairScreenViewInput?
    
    private(set) var pair: CurrencyPair
    private var currencies: [CurrencyModel] = []
    private var selectedSlot: CurrencyPairSlot? = nil
    var rate: Double = 1.0
    
    private var currencyFilter: CurrencyType? = nil
    
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
        
        self.rate = .random(in: 0.1...1000)
    }
    
    private func refreshCurrencyListOnView() {
        let list = getAvailableCurrencies()
        let showEmptyFavoritesPlaceholder =
        isShowingOnlyFavorites && selectedSlot != nil && list.isEmpty
        view?.updateCurrencyList(list, showEmptyFavoritesPlaceholder: showEmptyFavoritesPlaceholder)
    }
}

extension CurrencyPairScreenPresenter: CurrencyPairScreenPresenterInput {
    func selectSlot(_ slot: CurrencyPairSlot) {
        selectedSlot = slot
        refreshCurrencyListOnView()
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
        refreshCurrencyListOnView()
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
        refreshCurrencyListOnView()
    }
    
    func showOnlyFavorites(_ only: Bool) {
        isShowingOnlyFavorites = only
        refreshCurrencyListOnView()
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
        refreshCurrencyListOnView()
    }
}
