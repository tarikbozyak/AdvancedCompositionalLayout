//
//  Section.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

typealias SectionLayout = (NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection

class Section: Hashable {
    
    let uuid = UUID()
    let data: [AnyHashable]
    let cellType: UICollectionViewCell.Type
    let layout: SectionLayout
    
    init(data: [AnyHashable], cellType: UICollectionViewCell.Type, layout: @escaping SectionLayout) {
        self.data = data
        self.cellType = cellType
        self.layout = layout
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
