//
//  BasicList.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation
import UIKit

typealias BasicListSnapshot = NSDiffableDataSourceSnapshot<Int, Person>
typealias BasicListDataSource = UICollectionViewDiffableDataSource<Int, Person>

class BasicList: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: BasicListDataSource!
    
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
            content.image = UIImage(named: "user\(indexPath.row + 1)")
            content.imageProperties.maximumSize = .init(width: 60, height: 60)
            content.imageProperties.cornerRadius = 30
            content.text = personItem.name + " " + personItem.surname
            content.secondaryText = personItem.job
            content.secondaryTextProperties.color = .systemGray2
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
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
        var snapshot = BasicListSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}
