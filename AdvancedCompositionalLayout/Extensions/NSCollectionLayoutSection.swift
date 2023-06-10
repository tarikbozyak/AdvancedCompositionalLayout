//
//  NSCollectionLayoutSection.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 2.05.2023.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    
    static func nestedGroupLayout() -> NSCollectionLayoutSection {
        //First group item
        let firstGroupItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        firstGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //First nested group
        let firstNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(1)), subitems: [firstGroupItem])
        
        //Second group item
        let secondGroupItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        secondGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //Second nested group
        let secondNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1)), subitems: [secondGroupItem])
        
        //Final group
        let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [firstNestedGroup, secondNestedGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    static func nestedGroupLayout2() -> NSCollectionLayoutSection {
        //First group item 1
        let firstGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1)))
        firstGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //First group item 2
        let firstGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)))
        firstGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //First nested group
        let firstNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [firstGroupItem1, firstGroupItem2])
        
        //--------------------------------------
        
        //Second group first inner group item 1
        let secondGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .fractionalHeight(1)))
        secondGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //Second group first inner group item 2
        let secondGroupFirstInnerGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.65), heightDimension: .fractionalHeight(1)))
        secondGroupFirstInnerGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //Second group first inner group
        let secongGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.6)), subitems: [secondGroupFirstInnerGroupItem1, secondGroupFirstInnerGroupItem2])
        
        //--------------
        
        //Second group second inner group item 1
        let secondGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        secondGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //Second group second inner group
        let secongGroupSecondInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [secondGroupSecondInnerGroupItem1])
        
        //Second group first nested group
        let secongGroupFirstNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1)), subitems: [secongGroupFirstInnerGroup, secongGroupSecondInnerGroup])
        
        //--------------
        
        //Second group second inner group item 1
        let secongGroupSecondNestedGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        secongGroupSecondNestedGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //Second group second nested group
        let secongGroupSecondNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1)), subitems: [secongGroupSecondNestedGroupItem1])
        
        //Second nested group
        let secondNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7)), subitems: [secongGroupFirstNestedGroup, secongGroupSecondNestedGroup])
        
        //--------------------------------------
        
        //Final group
        let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.25)), subitems: [firstNestedGroup, secondNestedGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
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
    
    static func verticalWaterfallSection(config: WaterfallConfiguration) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let builder = VerticalWaterfallBuilder(config: config)
        
        for i in 0..<config.dataCount {
            let item = builder.prepareItem(for: i)
            items.append(item)
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(builder.maxHeight))
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: config.sectionHorizontalSpacing, bottom: 16, trailing: config.sectionHorizontalSpacing)
        
        return section
    }
    
    static func stackWaterfallSection(config: WaterfallConfiguration) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let builder = StackWaterfallBuilder(config: config)
        
        for i in 0..<config.dataCount {
            let item = builder.prepareItem(for: i)
            items.append(item)
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(builder.maxHeight))
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: config.sectionHorizontalSpacing, bottom: 16, trailing: config.sectionHorizontalSpacing)
        
        return section
    }
    
    static func horizontalWaterfallSection(config: WaterfallConfiguration) -> NSCollectionLayoutSection {
        var items = [NSCollectionLayoutGroupCustomItem]()
        let builder = HorizontalWaterfallBuilder(config: config)
        
        for i in 0..<config.dataCount {
            let item = builder.prepareItem(for: i)
            items.append(item)
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(builder.maxWidth) , heightDimension: .fractionalHeight(0.6))
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: config.sectionVerticalSpacing, bottom: 16, trailing: config.sectionVerticalSpacing)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
}

