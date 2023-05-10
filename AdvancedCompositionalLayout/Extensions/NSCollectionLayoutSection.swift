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
    
    static func loadingSection() -> NSCollectionLayoutSection {
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 10
        section.contentInsets.bottom = 30
        
        return section
    }
}

