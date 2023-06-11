//
//  NestedGroupType.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 11.06.2023.
//

import Foundation

enum NestedGroupType: Hashable {
    case vertical
    case horizontal(layoutId: Int)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .vertical:
            break
        case .horizontal(let layoutId):
            return hasher.combine(layoutId)
        }
    }
}
