//
//  ChartAssembly.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

enum ChartAssembly {
    static func makeChart(base: String, counter: String) -> UIViewController {
        let presenter = ChartPresenter(base: base, counter: counter)
        let viewController = ChartViewController(output: presenter)
        presenter.view = viewController
        return viewController
    }
}
