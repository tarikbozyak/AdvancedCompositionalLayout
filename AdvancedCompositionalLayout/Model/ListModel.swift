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
    
    var viewController: UIViewController?{
        switch self {
        case .simpleList: return SimpleListViewController()
        case .supplementary: return SupplementaryViewController()
        case .multiSectionList: return nil
        case .gridLayout: return GridViewController()
        case .nestedGroup: return NestedViewController(type: .vertical)
        case .waterfall: return WaterfallViewController(type: .vertical)
        case .horizontalWaterfall: return WaterfallViewController(type: .horizontal)
        case .stackWaterfall: return WaterfallViewController(type: .stack)
        }
    }
}

struct ListItem: Hashable {
    let id = UUID()
    let title: String
    let type: ListType?
    let subItems: [ListItem]
    
    init(type: ListType, subItems: [ListItem] = []) {
        self.type = type
        self.subItems = subItems
        self.title = type.rawValue
    }
    
    init(title: String, subItems: [ListItem] = []) {
        self.type = ListType(rawValue: title)
        self.subItems = subItems
        self.title = title
    }
}
