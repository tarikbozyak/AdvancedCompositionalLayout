//
//  NestedGroup.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 5.06.2023.
//

import Foundation
import UIKit

class NestedGroup: UICollectionView {
    
    weak var rootVC: UIViewController!

    var type: NestedGroupType?
    
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
        
        let listCellRegistration = UICollectionView.CellRegistration<NestedCell, Int> { (cell, indexPath, item) in
            cell.configure(with: item)
            cell.backgroundColor = UIColor(named: "section\((indexPath.row % 8) + 1 )CellColor")
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: self.data[indexPath.row])
        }
    }
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let type = type else {return nil}
        switch type {
        case .vertical:
            return .verticalNestedGroupLayout()
        case .horizontal(let layoutID):
            if layoutID == 1 {
                return .horizontalNestedGroupLayout1()
            }
            else if layoutID == 2 {
                return .horizontalNestedGroupLayout2()
            }
            else if layoutID == 3 {
                return .horizontalNestedGroupLayout3()
            }
            else {
                return .horizontalNestedGroupLayout1()
            }
        }
    }
    
    func performUpdates(){
        var snapshot = GridSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}

