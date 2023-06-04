//
//  WaterfallConfiguration.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

typealias ItemHeightProvider = () -> CGFloat
typealias ItemWidthProviderByIndex = (_ index: Int) -> (CGFloat)
typealias ItemWidthProvider = () -> CGFloat

struct WaterfallConfiguration {
    public let dataCount: Int
    public let columnCount: Int
    public let rowCount: Int
    public let itemSpacing: CGFloat
    public let sectionHorizontalSpacing: CGFloat
    public let sectionVerticalSpacing: CGFloat
    public let itemHeightProvider: ItemHeightProvider
    public let itemWitdthProviderByIndex: ItemWidthProviderByIndex
    public let itemWidthProvider: ItemWidthProvider
    public let environment: NSCollectionLayoutEnvironment
        
    public init(
        dataCount: Int,
        columnCount: Int = 2,
        rowCount: Int = 2,
        itemSpacing: CGFloat = 8,
        sectionHorizontalSpacing: CGFloat = 0,
        sectionVerticalSpacing: CGFloat = 0,
        itemHeightProvider: @escaping ItemHeightProvider = { return CGFloat.random(in: 250...500) },
        itemWitdthProviderByIndex: @escaping ItemWidthProviderByIndex = { index in return (0) },
        itemWidthProvider: @escaping ItemWidthProvider = { return CGFloat.random(in: 50...120) },
        environment: NSCollectionLayoutEnvironment
    ) {
        self.dataCount = dataCount
        self.columnCount = columnCount
        self.rowCount = rowCount
        self.itemSpacing = itemSpacing
        self.sectionHorizontalSpacing = sectionHorizontalSpacing
        self.sectionVerticalSpacing = sectionVerticalSpacing
        self.itemHeightProvider = itemHeightProvider
        self.itemWitdthProviderByIndex = itemWitdthProviderByIndex
        self.itemWidthProvider = itemWidthProvider
        self.environment = environment
    }
}
