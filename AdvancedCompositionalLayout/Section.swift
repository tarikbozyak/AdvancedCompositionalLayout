//
//  Section.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

typealias SectionLayout = (NSCollectionLayoutEnvironment, Int) -> NSCollectionLayoutSection

class Section: Hashable {
    
    let uuid = UUID()
    let title: String
    let data: [AnyHashable]
    let cellType: UICollectionViewCell.Type
    let layout: SectionLayout
    
    init(title: String ,data: [AnyHashable], cellType: UICollectionViewCell.Type, layout: @escaping SectionLayout) {
        self.title = title
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
