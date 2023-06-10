//
//  ListModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.04.2023.
//

import Foundation
import UIKit

enum ListType: String {
    case simpleList = "Simple List Layout"
    case supplementary = "Supplementary View List"
    case multiSectionList = "Multi Section List"
    case gridLayout = "Grid Layout"
    case nestedGroup = "Nested Group Layout"
    case waterfall = "Waterfall Layout"
    case horizontalWaterfall = "Horizontal Waterfall Layout"
    case stackWaterfall = "Stack Waterfall Layout"
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
        self.title = type.rawValue
        self.image = UIImage(systemName: "star.fill")!
    }
}
