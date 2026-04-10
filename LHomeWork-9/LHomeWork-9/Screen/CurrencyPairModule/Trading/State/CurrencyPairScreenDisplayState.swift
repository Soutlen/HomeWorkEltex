//
//  CurrencyPairScreenDisplayState.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import Foundation

enum CurrencyPairScreenDisplayState: Equatable {
    case empty
    case active(rate: Double)
}
