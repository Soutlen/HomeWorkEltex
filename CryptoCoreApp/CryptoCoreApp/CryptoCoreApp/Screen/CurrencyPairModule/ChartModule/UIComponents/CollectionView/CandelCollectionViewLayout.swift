//
//  CandelCollectionViewLayout.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CandleCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: 40, height: 160)
        sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
