//
//  PriceGenerator.swift
//  LHomeWork-4
//
//  Created by Евгений Глоба on 3/21/26.
//

import Foundation

protocol IPriceGenerator {
    func nextPrice() -> Double
}

struct PriceGenerator: IPriceGenerator {
    func nextPrice() -> Double {
        return 800 + Double.random(in: -200...200)
    }
}
