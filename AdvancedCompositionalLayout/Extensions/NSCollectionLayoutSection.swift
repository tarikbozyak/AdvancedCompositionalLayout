//
//  NSCollectionLayoutSection.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 2.05.2023.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    
    static func gridSection(columnCount: Int) -> NSCollectionLayoutSection {
        let columnCount = CGFloat(columnCount)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/columnCount), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/columnCount))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    static func waterfallSection(config: WaterfallConfiguration) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let builder = WaterfallBuilder(config: config)
        
        for i in 0..<config.itemCountProvider() {
            let item = builder.prepareItem(for: i)
            items.append(item)
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(builder.maxHeight))
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: config.sectionHorizontalSpacing/2, bottom: 16, trailing: config.sectionHorizontalSpacing/2)
        
        return section
    }
    
}

