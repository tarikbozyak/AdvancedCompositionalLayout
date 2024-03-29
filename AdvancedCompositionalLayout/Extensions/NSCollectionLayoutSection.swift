//
//  NSCollectionLayoutSection.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 2.05.2023.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    
    static func menuSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8 )
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func grandTaskSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(470))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    static func taskBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets.leading = 8
        group.contentInsets.trailing = 8
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 12
        section.contentInsets.bottom = 24
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    static func taskStatisticsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 12, leading: 8, bottom: 25, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func taskActivitySection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.bottom = 12
        
        //group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        group.contentInsets.leading = 8
        group.contentInsets.trailing = 8
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 24, trailing: 0)
        
        return section
    }
    
    static func personSection(showBadgeViews: Bool = false) -> NSCollectionLayoutSection {
        
        let badgeView: [NSCollectionLayoutSupplementaryItem] = showBadgeViews ? getBadgeView() : []
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: badgeView)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 12, leading: 0, bottom: 24, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func gridSection(columnCount: Int, showBadgeViews: Bool = false) -> NSCollectionLayoutSection {
        let columnCount = CGFloat(columnCount)
        let badgeView: [NSCollectionLayoutSupplementaryItem] = showBadgeViews ? getBadgeView() : []
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/columnCount), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: badgeView)
        
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/columnCount))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 20
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
        section.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
        
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(builder.maxWidth) , heightDimension: config.sectionHeight!)
        
        let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in
            return items
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 12, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
}

// Nested Group
extension NSCollectionLayoutSection {
    
    static func nestedGroupLayout1() -> NSCollectionLayoutSection {
        
        //First group first inner group
        let firstGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.55)))
        firstGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupFirstInnerGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45)))
        firstGroupFirstInnerGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        //First nested group
        let firstNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0)), subitems: [firstGroupFirstInnerGroupItem1, firstGroupFirstInnerGroupItem2])
        
        //--------------------------------------
        
        //Second group first inner group
        let secondGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1)))
        secondGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1)))
        secondGroupFirstInnerGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)), subitems: [secondGroupFirstInnerGroupItem1, secondGroupFirstInnerGroupItem2])
        
        //--------------
        
        //Second group second inner group
        let secondGroupSecondInnerGroupFirstGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupFirstGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroupFirstGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupFirstGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroupFirstGroupFirstInner = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.55)), subitems: [secondGroupSecondInnerGroupFirstGroupItem1, secondGroupSecondInnerGroupFirstGroupItem2])
        
        //--------------
        
        let secondGroupSecondInnerGroupFirstGroupItem3 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupFirstGroupItem3.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroupFirstGroupItem4 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupFirstGroupItem4.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroupFirstGroupSecondInner = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45)), subitems: [secondGroupSecondInnerGroupFirstGroupItem3, secondGroupSecondInnerGroupFirstGroupItem4])
        
        let secondGroupSecondInnerGroupFirstGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1)), subitems: [secondGroupSecondInnerGroupFirstGroupFirstInner, secondGroupSecondInnerGroupFirstGroupSecondInner])
        
        //--------------
        
        let secondGroupSecondInnerGroupSecondGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupSecondGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroupSecondGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitems: [secondGroupSecondInnerGroupSecondGroupItem1])
        
        let secondGroupSecondInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7)), subitems: [secondGroupSecondInnerGroupFirstGroup, secondGroupSecondInnerGroupSecondGroup])
        
        //--------------
        
        //Second nested group
        let secondNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1.0)), subitems: [secondGroupFirstInnerGroup, secondGroupSecondInnerGroup])
        
        //--------------------------------------
        
        //Final group
        let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.25)), subitems: [firstNestedGroup, secondNestedGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func nestedGroupLayout2(type: NestedGroupType) -> NSCollectionLayoutSection {
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
        switch type {
        case .vertical:
            //Final group
            let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25)), subitems: [firstNestedGroup, secondNestedGroup])
            
            //Section
            let section = NSCollectionLayoutSection(group: finalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
            return section
        case .horizontal:
            //Final group
            let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.25)), subitems: [firstNestedGroup, secondNestedGroup])
            
            //Section
            let section = NSCollectionLayoutSection(group: finalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        
    }
    
    
    static func nestedGroupLayout3() -> NSCollectionLayoutSection {
        
        //First group first inner group
        let firstGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        firstGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8)), subitems: [firstGroupFirstInnerGroupItem1])
        
        //First group second inner group
        let firstGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        firstGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupSecondInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [firstGroupSecondInnerGroupItem1])
        
        //First nested group
        let firstNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/7), heightDimension: .fractionalHeight(1)), subitems: [firstGroupFirstInnerGroup,firstGroupSecondInnerGroup])
        
        //--------------------------------------
        
        //Second group first inner group
        let secondGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        secondGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [secondGroupFirstInnerGroupItem1])
        
        //Second group second inner group
        let secondGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        secondGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.6)), subitems: [secondGroupSecondInnerGroupItem1])
        
        //Second group third inner group
        let secondGroupThirdInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        secondGroupThirdInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupThirdInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [secondGroupThirdInnerGroupItem1])
        
        //Second nested group
        let secondNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(3/7), heightDimension: .fractionalHeight(1)), subitems: [secondGroupFirstInnerGroup, secondGroupSecondInnerGroup, secondGroupThirdInnerGroup])
        
        //--------------------------------------
        
        //Third group first inner group
        let thirdGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        thirdGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let thirdGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [firstGroupSecondInnerGroupItem1])
        
        
        //Third group second inner group
        let thirdGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        thirdGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let thirdGroupSecondInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8)), subitems: [thirdGroupSecondInnerGroupItem1])
        
        //Third nested group
        let thirdNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/7), heightDimension: .fractionalHeight(1)), subitems: [thirdGroupFirstInnerGroup,thirdGroupSecondInnerGroup])
        
        //--------------------------------------
        
        //Final group
        let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [firstNestedGroup, secondNestedGroup, thirdNestedGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
        
    }
    
    static func nestedGroupLayout4() -> NSCollectionLayoutSection {
        
        //First nested group
        
        let firstGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(1.0)))
        firstGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6)))
        firstGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupSecondInnerGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4)))
        firstGroupSecondInnerGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let firstGroupSecondInnerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1.0)), subitems: [firstGroupSecondInnerGroupItem1, firstGroupSecondInnerGroupItem2])
        
        let firstNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25)), subitems: [firstGroupItem1, firstGroupSecondInnerGroup])
        
        //--------------------------------------
        
        //Second nested group
        
        let secondGroupFirstInnerGroupFirstInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1.0)))
        secondGroupFirstInnerGroupFirstInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroupFirstInnerGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0)))
        secondGroupFirstInnerGroupFirstInnerGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroupFirstInnerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.65)), subitems: [secondGroupFirstInnerGroupFirstInnerGroupItem1, secondGroupFirstInnerGroupFirstInnerGroupItem2])
        
        
        let secondGroupFirstInnerGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        secondGroupFirstInnerGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupFirstInnerGroupSecondInnerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35)), subitems: [secondGroupFirstInnerGroupSecondInnerGroupItem1])
        
        let secondGroupFirstInnerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.65), heightDimension: .fractionalHeight(1.0)), subitems: [secondGroupFirstInnerGroupFirstInnerGroup, secondGroupFirstInnerGroupSecondInnerGroup])
        
        let secondGroupSecondInnerGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        secondGroupSecondInnerGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let secondGroupSecondInnerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .fractionalHeight(1.0)), subitems: [secondGroupSecondInnerGroupItem1])
        
        let secondNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25)), subitems: [secondGroupFirstInnerGroup, secondGroupSecondInnerGroup])
        
        //--------------------------------------
        
        //Third nested group
        let thirdGroupItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        thirdGroupItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let thirdNestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), subitems: [thirdGroupItem])
        
        //--------------------------------------
        
        //Fourth nested group
        
        let fourthGroupFirstGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3)))
        fourthGroupFirstGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let fourthGroupFirstGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(1.0)), subitems: [fourthGroupFirstGroupItem1])
        
        let fourthGroupSecondGroupItem1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.55)))
        fourthGroupSecondGroupItem1.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let fourthGroupSecondGroupItem2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45)))
        fourthGroupSecondGroupItem2.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let fourthGroupSecondGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0)), subitems: [fourthGroupSecondGroupItem1, fourthGroupSecondGroupItem2])
        
        let fourthNestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45)), subitems: [fourthGroupFirstGroup, fourthGroupSecondGroup])
        
        //Final group
        let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1000)), subitems: [firstNestedGroup, secondNestedGroup, thirdNestedGroup, fourthNestedGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        return section
    }
}

// Supplementary Configuration
extension NSCollectionLayoutSection {
    func addHeader(pinToVisibleBounds: Bool = true) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.zIndex = 20
        header.pinToVisibleBounds = pinToVisibleBounds
        boundarySupplementaryItems += [header]
    }
    
    func addFooter(pinToVisibleBounds: Bool = false) {
        contentInsets.bottom = 8
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        footer.zIndex = 20
        footer.pinToVisibleBounds = pinToVisibleBounds
        boundarySupplementaryItems += [footer]
    }
    
    func addPagerFooter(pinToVisibleBounds: Bool = false) {
        contentInsets.bottom = 8
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        footer.zIndex = 20
        footer.pinToVisibleBounds = pinToVisibleBounds
        boundarySupplementaryItems += [footer]
    }
    
    func addDecorationView(decorationView: AnyClass, elementKind: String, layout: UICollectionViewLayout?) {
        layout?.register(decorationView, forDecorationViewOfKind: elementKind)
        let background = NSCollectionLayoutDecorationItem.background(elementKind: elementKind)
        decorationItems += [background]
    }
    
    static func getBadgeView() -> [NSCollectionLayoutSupplementaryItem] {
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.2, y: -0.2))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: "badgeElementKind", containerAnchor: badgeAnchor)
        return [badge]
    }
}

//VisibleItemsHandler
extension NSCollectionLayoutSection {
    func addVisibleItemsHandler(with listener: PageListener?, sectionIndex: Int){
        visibleItemsInvalidationHandler = { (items, offset, env) -> Void in
            let page = round(offset.x / env.container.contentSize.width)
            listener?.send(Page(pageIndex: Int(page), sectionIndex: sectionIndex))
        }
    }
}

