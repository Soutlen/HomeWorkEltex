//
//  PriceGeneratorCurrency.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

protocol PriceGeneratorCurrencyProtocol {
    func nextPrice() -> Double
    var startPrice: Double { get }
}

struct PriceGeneratorCurrency: PriceGeneratorCurrencyProtocol {
    
    var startPrice: Double = 800
    
    func nextPrice() -> Double {
        return startPrice + Double.random(in: -200...200)
    }
}

