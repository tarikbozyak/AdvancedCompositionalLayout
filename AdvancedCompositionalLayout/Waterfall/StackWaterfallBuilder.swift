//
//  StackWaterfallBuilder.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 2.06.2023.
//

import Foundation
import UIKit


// First item : rowWidth

final class StackWaterfallBuilder {
    private let config: WaterfallConfiguration
    lazy var rowWidths = Dictionary<Int, CGFloat>()
    

    var currentRowIndex: Int = 0
    var currentRowWidth: CGFloat { return rowWidths[currentRowIndex] ?? 0}
    var collectionWidth: CGFloat { return config.environment.container.contentSize.width}
    var maxHeight: CGFloat = 0
    
    var itemHeightProvider: ItemWidthProvider { config.itemHeightProvider }
    var itemSpacing: CGFloat { config.itemSpacing }
    var sectionVerticalSpacing: CGFloat { config.sectionVerticalSpacing}
    var sectionHorizontalSpacing: CGFloat { config.sectionHorizontalSpacing * 2}
    
    init(config: WaterfallConfiguration) {
        self.config = config
    }
    
    func calculateFrame(for row: Int) -> (frame: CGRect , isCurrentIndexNeedsUpdate: Bool) {
        
        var currentItemWidth = config.itemWitdthProviderByIndex(row)
        let nextItemWidth = config.itemWitdthProviderByIndex(row + 1)
        
        if (currentRowWidth + currentItemWidth + nextItemWidth + sectionHorizontalSpacing) > collectionWidth {
            currentItemWidth = collectionWidth - currentRowWidth - sectionHorizontalSpacing
            rowWidths[currentRowIndex] = currentRowWidth
            let rowHeight = itemHeightProvider()
            let width = currentItemWidth
            let height = rowHeight
            let size = CGSize(width: width, height: height)
            let xCoordinate = currentRowWidth.rounded()
            let yCoordinate = (height + itemSpacing) * CGFloat(currentRowIndex)
            return ( CGRect(origin: CGPoint(x: xCoordinate, y: yCoordinate), size: size) , true)
        }
        
        else {
            rowWidths[currentRowIndex] = currentRowWidth
            let rowHeight = itemHeightProvider()
            let width = currentItemWidth
            let height = rowHeight
            let size = CGSize(width: width, height: height)
            let xCoordinate = currentRowWidth.rounded()
            let yCoordinate = (height + itemSpacing) * CGFloat(currentRowIndex)
            return (CGRect(origin: CGPoint(x: xCoordinate, y: yCoordinate), size: size), false)
        }

    }
    
    func prepareItem(for row: Int) -> NSCollectionLayoutGroupCustomItem {
        let result = calculateFrame(for: row)
        let frame = result.frame
        rowWidths[currentRowIndex] = frame.maxX + itemSpacing
        maxHeight = frame.maxY + sectionVerticalSpacing
        if result.isCurrentIndexNeedsUpdate {
            currentRowIndex += 1
        }
        return NSCollectionLayoutGroupCustomItem(frame: frame)
    }
}

