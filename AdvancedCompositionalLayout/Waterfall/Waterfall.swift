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

class Waterfall: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: WaterfallDataSource!
    
    var columnCount: Int = 2
    
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
        
        let listCellRegistration = UICollectionView.CellRegistration<WaterfallCell, Int> { (cell, indexPath, item) in
            cell.configure(with: item)
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: self.data[indexPath.row])
            
        }
    }
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {

        let itemCountProvider: ItemCountProvider = { [weak self] in
            return self?.data.count ?? 0
        }
        
        let itemHeightProvider: ItemHeightProvider = { index, itemWidth in
            return CGFloat.random(in: 250...500)
        }
        
        let config = WaterfallConfiguration(columnCount: 2, itemSpacing: 10, sectionHorizontalSpacing: 16, itemCountProvider: itemCountProvider, itemHeightProvider: itemHeightProvider, environment: environment)
        
        return .waterfallSection(config: config)
    }
    
    func performUpdates(){
        var snapshot = WaterfallSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}

