//
//  WaterfallConfiguration.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

typealias ItemHeightProvider = (_ index: Int, _ itemWidth: CGFloat) -> CGFloat

struct WaterfallConfiguration {
    public let dataCount: Int
    public let columnCount: Int
    public let itemSpacing: CGFloat
    public let sectionHorizontalSpacing: CGFloat
    public let itemHeightProvider: ItemHeightProvider
    public let environment: NSCollectionLayoutEnvironment
        
    public init(
        dataCount: Int,
        columnCount: Int = 2,
        itemSpacing: CGFloat = 8,
        sectionHorizontalSpacing: CGFloat = 0,
        itemHeightProvider: @escaping ItemHeightProvider,
        environment: NSCollectionLayoutEnvironment
    ) {
        self.dataCount = dataCount
        self.columnCount = columnCount
        self.itemSpacing = itemSpacing
        self.sectionHorizontalSpacing = sectionHorizontalSpacing
        self.itemHeightProvider = itemHeightProvider
        self.environment = environment
    }
}
