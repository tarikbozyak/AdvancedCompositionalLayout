//
//  ListModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.04.2023.
//

import Foundation
import UIKit

enum ListType {
    case simpleList
    case supplementary
    case multiSectionList
    case gridLayout
    case waterfallLayout
    case horizontalWaterfallLayout
}


enum MenuDataType: Hashable {
    case header(MenuSection)
    case list(ListItem)
}

struct MenuSection: Hashable {
    let title: String
    let menuList: [ListItem]
}

struct ListItem: Hashable {
    let type: ListType
    let title: String
    let image: UIImage
    
    init(type: ListType) {
        self.type = type
        switch type {
        case .simpleList:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Simple List"
        case .multiSectionList:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Multi Section List"
        case .supplementary:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Supplementary View List"
        case .gridLayout:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Grid Layout"
        case .waterfallLayout:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Waterfall Layout"
        case .horizontalWaterfallLayout:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Horizontal Waterfall Layout"
        }
    }
}
