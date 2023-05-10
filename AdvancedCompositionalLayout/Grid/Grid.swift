//
//  Grid.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.05.2023.
//


import UIKit

typealias GridSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
typealias GridDataSource = UICollectionViewDiffableDataSource<Int, Int>

class Grid: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: GridDataSource!
    
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
        
        let listCellRegistration = UICollectionView.CellRegistration<GridCell, Int> { (cell, indexPath, item) in
            cell.configure(with: item)
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: self.data[indexPath.row])
            
        }
    }
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return .gridSection(columnCount: columnCount)
    }
    
    func performUpdates(){
        var snapshot = GridSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}
