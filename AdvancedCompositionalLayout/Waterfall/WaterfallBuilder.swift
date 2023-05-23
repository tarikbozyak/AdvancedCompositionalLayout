//
//  WaterfallBuilder.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

final class WaterfallBuilder {
    private let config: WaterfallConfiguration
    private lazy var columnHeights = [CGFloat](repeating: 0, count: self.config.columnCount)
    
    var columnCount: CGFloat { CGFloat(config.columnCount) }
    var itemHeightProvider: ItemHeightProvider { config.itemHeightProvider }
    var interItemSpacing: CGFloat { config.itemSpacing }
    var sectionHorizontalSpacing: CGFloat { config.sectionHorizontalSpacing * 2 }
    var maxHeight: CGFloat { columnHeights.max() ?? 0 }
    var columnIndex: Int { columnHeights.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0 }
    var collectionWidth: CGFloat {config.environment.container.contentSize.width}
    
    init(config: WaterfallConfiguration) {
        self.config = config
    }
    
    func calculateFrame(for row: Int) -> CGRect {
        let spacing = (columnCount - 1) * interItemSpacing
        let columnWidth = (collectionWidth - spacing - sectionHorizontalSpacing) / columnCount
        let width = columnWidth
        let height = itemHeightProvider(row, width)
        let size = CGSize(width: width, height: height)
        let xCoordinate = (width + interItemSpacing) * CGFloat(columnIndex)
        let yCoordinate = columnHeights[columnIndex].rounded()
        return CGRect(origin: CGPoint(x: xCoordinate, y: yCoordinate), size: size)
    }
    
    func prepareItem(for row: Int) -> NSCollectionLayoutGroupCustomItem {
        let frame = calculateFrame(for: row)
        columnHeights[columnIndex] = frame.maxY + interItemSpacing
        return NSCollectionLayoutGroupCustomItem(frame: frame)
    }
}
