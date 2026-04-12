//
//  TabBarController.swift
//  LHomeWork-9
//
//  Created by Евгений Глоба on 4/11/26.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarController {
    func setupTabBar() {
        let tradingRoot = CurrencyPairScreenAssembly.buildViewController()
        let navigation = UINavigationController(rootViewController: tradingRoot)
        
        navigation.tabBarItem = UITabBarItem(
            title: "Trade",
            image: UIImage(systemName: "chart.line.uptrend.xyaxis"),
            selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis")
        )
        
        viewControllers = [ navigation ]
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }
}
