//
//  ListModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.04.2023.
//

import Foundation
import UIKit

enum ListSection: Hashable {
    case headerCell(MenuHeaderItem)
    case listCell(MenuListItem)
}

struct MenuHeaderItem: Hashable {
    let title: String
    let symbols: [MenuListItem]
}

struct MenuListItem: Hashable {
    let title: String
    let image: UIImage
    
    init(imageName: String, title: String) {
        self.image = UIImage(systemName: imageName)!
        self.title = title
    }
}
