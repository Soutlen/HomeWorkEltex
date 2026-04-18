//
//  ChartModel.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import Foundation

struct CandleModel {
    let id: Int
    let openCandel: Double
    let closeCandel: Double
    let highCandel: Double
    let lowCandel: Double
    
    var isBullish: Bool {
        closeCandel >= openCandel
    }
}

