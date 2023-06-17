//
//  HorizontalWaterfallBuilder.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 31.05.2023.
//

import Foundation
import UIKit

final class HorizontalWaterfallBuilder {
    private let config: WaterfallConfiguration
    private lazy var rowWidths = [CGFloat](repeating: 0, count: config.rowCount)
    
    var startPoint: CGFloat = 3
    var rowCount: CGFloat { CGFloat(config.rowCount) }
    var itemWidthProvider: ItemWidthProvider { config.itemWidthProvider }
    var itemSpacing: CGFloat { config.itemSpacing }
    var sectionVerticalSpacing: CGFloat { config.sectionVerticalSpacing * 2 }
    var maxWidth: CGFloat { rowWidths.max() ?? 0 }
    var rowIndex: Int { rowWidths.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0 }
    var collectionHeight: CGFloat {
        if let height = config.sectionHeight {
            if height.isFractionalHeight {
                return height.dimension * config.environment.container.contentSize.height
            }
            else if height.isFractionalWidth {
                return height.dimension * config.environment.container.contentSize.width
            }
            else {
                return height.dimension
            }
        }
        else {
            return config.environment.container.contentSize.height * 0.5
        }
    }
    
    init(config: WaterfallConfiguration) {
        self.config = config
    }
    
    func calculateFrame(for row: Int) -> CGRect {
        let spacing = (rowCount - 1) * itemSpacing
        let rowHeight = (collectionHeight - spacing - sectionVerticalSpacing) / rowCount
        let width = itemWidthProvider()
        let height = rowHeight
        let size = CGSize(width: width, height: height)
        let xCoordinate = rowWidths[rowIndex].rounded() + startPoint
        let yCoordinate = (height + itemSpacing) * CGFloat(rowIndex)
        return CGRect(origin: CGPoint(x: xCoordinate, y: yCoordinate), size: size)
    }
    
    func prepareItem(for row: Int) -> NSCollectionLayoutGroupCustomItem {
        let frame = calculateFrame(for: row)
        rowWidths[rowIndex] = frame.maxX + itemSpacing
        return NSCollectionLayoutGroupCustomItem(frame: frame)
    }
}

