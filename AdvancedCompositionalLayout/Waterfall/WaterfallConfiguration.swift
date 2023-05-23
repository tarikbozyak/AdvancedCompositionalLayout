//
//  WaterfallConfiguration.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

typealias ItemHeightProvider = (_ index: Int, _ itemWidth: CGFloat) -> CGFloat
typealias ItemCountProvider = () -> Int

struct WaterfallConfiguration {
    public let columnCount: Int
    public let itemSpacing: CGFloat
    public let sectionHorizontalSpacing: CGFloat
    public let itemHeightProvider: ItemHeightProvider
    public let itemCountProvider: ItemCountProvider
    public let environment: NSCollectionLayoutEnvironment
        
    public init(
        columnCount: Int = 2,
        itemSpacing: CGFloat = 8,
        sectionHorizontalSpacing: CGFloat = 0,
        itemCountProvider: @escaping ItemCountProvider,
        itemHeightProvider: @escaping ItemHeightProvider,
        environment: NSCollectionLayoutEnvironment
    ) {
        self.columnCount = columnCount
        self.itemSpacing = itemSpacing
        self.sectionHorizontalSpacing = sectionHorizontalSpacing * 2
        self.itemCountProvider = itemCountProvider
        self.itemHeightProvider = itemHeightProvider
        self.environment = environment
    }
}
