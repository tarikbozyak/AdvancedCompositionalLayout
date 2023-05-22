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
    
    static func waterfallSection(config: WaterfallConfiguration, enviroment: NSCollectionLayoutEnvironment, sectionIndex: Int ) -> NSCollectionLayoutSection {
        
        // NSCollectionLayoutGroupCustomItem to create layout with custom frames
        var items = [NSCollectionLayoutGroupCustomItem]()
        
        
        let itemProvider = WaterfallBuilder(config: config)
        
        for i in 0..<config.itemCountProvider() {
            let item = itemProvider.makeLayoutItem(for: i)
            items.append(item)
        }
        
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(itemProvider.maxHeight))
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupLayoutSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsetsReference = config.contentInsetsReference
        return section
    }
    
}

