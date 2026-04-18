//
//  CurrencyPairCollectionViewLayout.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class CurrencyPairCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3
        let spacing = minimumInteritemSpacing
        let totalSpacing = (numberOfColumns - 1) * spacing
        
        let itemWidth = (availableWidth - totalSpacing) / numberOfColumns
        let itemHeight: CGFloat = 60
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}
