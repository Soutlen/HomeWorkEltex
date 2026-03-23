//
//  PriceGenerator.swift
//  LHomeWork-5
//
//  Created by Евгений Глоба on 3/23/26.
//

import Foundation

protocol PriceGeneratorProtocol {
    func nextPrice() -> Double
}

struct PriceGenerator: PriceGeneratorProtocol {
    
    let startPrice: Double = 800
    
    func nextPrice() -> Double {
        return startPrice + Double.random(in: -200...200)
    }
}
