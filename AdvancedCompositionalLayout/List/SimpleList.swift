//
//  SimpleList.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation
import UIKit

typealias SimpleListSnapshot = NSDiffableDataSourceSnapshot<Int, Person>
typealias SimpleListDataSource = UICollectionViewDiffableDataSource<Int, Person>

class SimpleList: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: SimpleListDataSource!
    
    var data: [Person] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [Person] ?? []
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
        setCollectionViewLayout(layout(), animated: false)
        contentInset.top = 20
        configureDataSource()
    }
    
    func configureDataSource(){
        
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Person> { (cell, indexPath, personItem) in
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "star.fill")
            content.text = personItem.name + " " + personItem.surname
            cell.contentConfiguration = content
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, Person>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: self.data[indexPath.row])
            
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func performUpdates(){
        var snapshot = SimpleListSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}
