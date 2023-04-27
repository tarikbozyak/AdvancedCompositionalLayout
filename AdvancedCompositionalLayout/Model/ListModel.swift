//
//  ListModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.04.2023.
//

import Foundation
import UIKit

enum ListType {
    case singleSectionList
    case multiSectionList
    case gridLayout
    case waterfallLayout
}


enum ListSection: Hashable {
    case headerCell(MenuHeaderItem)
    case listCell(MenuListItem)
}

struct MenuHeaderItem: Hashable {
    let title: String
    let items: [MenuListItem]
}

struct MenuListItem: Hashable {
    let type: ListType
    let title: String
    let image: UIImage
    
    init(type: ListType) {
        self.type = type
        switch type {
        case .singleSectionList:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Single Section List"
        case .multiSectionList:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Multi Section List"
        case .gridLayout:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Grid Layout"
        case .waterfallLayout:
            self.image = UIImage(systemName: "star.fill")!
            self.title = "Waterfall Layout"
        }
    }
}
