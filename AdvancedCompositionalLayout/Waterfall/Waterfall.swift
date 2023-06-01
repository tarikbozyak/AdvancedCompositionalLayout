//
//  Waterfall.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

typealias WaterfallSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
typealias WaterfallDataSource = UICollectionViewDiffableDataSource<Int, Int>

enum WaterfallType {
    case horizontal
    case vertical
}

class Waterfall: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: WaterfallDataSource!
    
    var columnCount: Int = 2
    
    var rowCount: Int = 8
    
    var type: WaterfallType?
    
    var data: [Int] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [Int] ?? []
    }
    
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        setCollectionViewLayout(UICollectionViewCompositionalLayout(sectionProvider: layout), animated: false)
        configureDataSource()
    }
    
    func configureDataSource(){
        
        let listCellRegistration = UICollectionView.CellRegistration<WaterfallCell, Int> { [weak self] (cell, indexPath, item) in
            cell.configure(with: item, type: self?.type ?? .vertical)
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: self.data[indexPath.row])
            
        }
    }
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        
        let type = type ?? .vertical
        
        switch type {
        case .horizontal:
            let itemWidthProvider: ItemWidthProvider = { return CGFloat.random(in: 150...300) }
            let config = WaterfallConfiguration(dataCount: data.count, rowCount: rowCount, itemSpacing: 10, sectionVerticalSpacing: 16, itemWidthProvider: itemWidthProvider, environment: environment)
            return .horizontalWaterfallSection(config: config)
        case .vertical:
            let itemHeightProvider: ItemHeightProvider = { return CGFloat.random(in: 250...500) }
            let config = WaterfallConfiguration(dataCount: data.count, columnCount: columnCount, itemSpacing: 10, sectionHorizontalSpacing: 16, itemHeightProvider: itemHeightProvider, environment: environment)
            return .verticalWaterfallSection(config: config)
        }
        
    }
    
    func performUpdates(){
        var snapshot = WaterfallSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}

