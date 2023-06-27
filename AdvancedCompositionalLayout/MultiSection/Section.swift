//
//  Section.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

typealias SectionLayout = (Int, NSCollectionLayoutEnvironment, Int, PageListener?) -> NSCollectionLayoutSection

class Section: Hashable {
    
    let uuid = UUID()
    let title: String
    let data: [AnyHashable]
    let cellType: UICollectionViewCell.Type
    let headerType: UICollectionReusableView.Type?
    let footerType: UICollectionReusableView.Type?
    let layout: SectionLayout
    
    lazy var pageListener = PageListener()
    
    init(
        title: String ,
        data: [AnyHashable],
        cellType: UICollectionViewCell.Type,
        headerType: UICollectionReusableView.Type? = nil,
        footerType: UICollectionReusableView.Type? = nil,
        layout: @escaping SectionLayout
    ) {
        self.title = title
        self.data = data
        self.cellType = cellType
        self.headerType = headerType
        self.footerType = footerType
        self.layout = layout
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
