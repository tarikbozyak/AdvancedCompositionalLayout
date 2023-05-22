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
    public let interItemSpacing: CGFloat
    public let sectionHorizontalSpacing: CGFloat
    public let contentInsetsReference: UIContentInsetsReference
    public let itemHeightProvider: ItemHeightProvider
    public let itemCountProvider: ItemCountProvider
    public let environment: NSCollectionLayoutEnvironment
        
    public init(
        columnCount: Int = 2,
        interItemSpacing: CGFloat = 8,
        sectionHorizontalSpacing: CGFloat = 0,
        contentInsetsReference: UIContentInsetsReference = .automatic,
        itemCountProvider: @escaping ItemCountProvider,
        itemHeightProvider: @escaping ItemHeightProvider,
        environment: NSCollectionLayoutEnvironment
    ) {
        self.columnCount = columnCount
        self.interItemSpacing = interItemSpacing
        self.sectionHorizontalSpacing = sectionHorizontalSpacing * 2
        self.contentInsetsReference = contentInsetsReference
        self.itemCountProvider = itemCountProvider
        self.itemHeightProvider = itemHeightProvider
        self.environment = environment
    }
}
