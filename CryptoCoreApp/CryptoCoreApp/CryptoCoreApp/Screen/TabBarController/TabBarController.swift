//
//  TabBarController.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
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
       
        let pairNav = UINavigationController(rootViewController: CurrencyPairScreenAssembly.makeCurrencyPairScreen())
        
        pairNav.tabBarItem = UITabBarItem(
            title: "Пара",
            image: UIImage(systemName: "dollarsign.arrow.circlepath"),
            selectedImage: nil
        )
        
        let tradeNav = UINavigationController(rootViewController: TradeScreenAssembly.makeTradeScreen())
        
        tradeNav.tabBarItem = UITabBarItem(
            title: "Симуляция",
            image: UIImage(systemName: "play.circle"),
            selectedImage: nil
        )
        
        viewControllers = [ tradeNav, pairNav ]
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }
}
