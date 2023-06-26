//
//  TabMenu.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import UIKit

struct Menu: Hashable {
    let id = UUID()
    let title: String
}

typealias MenuSnapshot = NSDiffableDataSourceSnapshot<Int, Menu>
typealias MenuDataSource = UICollectionViewDiffableDataSource<Int, Menu>

class TabMenu: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: MenuDataSource!
    
    var data: [Menu] = []
    
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
        
        let menuCellRegistration = UICollectionView.CellRegistration<MenuCell, Menu> { (cell, _, item) in
            cell.configure(with: item)
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Menu>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: menuCellRegistration, for: indexPath, item: self.data[indexPath.row])
            
        }
    }
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return .menuSection()
    }
    
    // MARK: PerformUpdates
    func performUpdates(completion: (() -> Void)? = nil){
        var snapshot = MenuSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true, completion: completion)
    }
    
}
