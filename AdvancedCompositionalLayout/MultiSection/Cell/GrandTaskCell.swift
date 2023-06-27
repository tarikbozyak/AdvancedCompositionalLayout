//
//  GrandTaskCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.06.2023.
//

import Foundation
import UIKit

class GrandTaskCell: UICollectionViewCell {
    
    lazy var collectionView = MultiSection()
    
    var sectionList: [Section] = []
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GrandCell coder has not been implemented")
    }
    
    func setupView(){
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.edgesToSuperviewBoundsWithAutoResizingMask()
        collectionView.sectionDelegate = self
    }
    
    func configure(with item: Section) {
        sectionList = [item]
        collectionView.performUpdates()
    }
    
}

extension GrandTaskCell: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionList
    }
}
