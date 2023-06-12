//
//  ListModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.04.2023.
//

import Foundation
import UIKit

struct ListItem: Hashable {
    let id = UUID()
    let title: String
    let type: ListType?
    let subItems: [ListItem]
    
    init(type: ListType, subItems: [ListItem] = []) {
        self.type = type
        self.subItems = subItems
        self.title = type.title
    }
    
    init(title: String, subItems: [ListItem] = []) {
        self.type = nil
        self.subItems = subItems
        self.title = title
    }
}

enum ListType {
    case simpleList
    case supplementary
    case multiSectionList
    case gridLayout
    case nestedGroup(type: NestedGroupType)
    case waterfall(type: WaterfallType)
    
    var viewController: UIViewController? {
        switch self {
        case .simpleList: return SimpleListViewController()
        case .supplementary: return SupplementaryViewController()
        case .multiSectionList: return nil
        case .gridLayout: return GridViewController()
        case .nestedGroup(let type): return NestedViewController(type: type)
        case .waterfall(let type): return WaterfallViewController(type: type)
        }
    }
    
    var title: String {
        switch self {
        case .simpleList: return "Simple List Layout"
        case .supplementary: return "Supplementary View List"
        case .multiSectionList: return "Multi Section List"
        case .gridLayout: return "Grid Layout"
        case .waterfall(let type): return "\(type.rawValue) Waterfall Layout"
        case .nestedGroup(let type):
            switch type {
            case .vertical: return "Vertical Nested Group Layout"
            case .horizontal(let layoutId): return "Horizontal Nested Group Layout \(layoutId)"
            }
        }
    }
    
    var id: UUID {
        return UUID()
    }
}

extension ListType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .nestedGroup(let type):
            hasher.combine(type)
        case .waterfall(let type):
            hasher.combine(type)
        default : break
        }
    }
    
    static func == (lhs: ListType, rhs: ListType) -> Bool {
        return lhs.id == rhs.id
    }
}
