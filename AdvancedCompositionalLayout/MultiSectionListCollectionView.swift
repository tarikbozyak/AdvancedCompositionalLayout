//
//  MultiSectionListCollectionView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.04.2023.
//

import Foundation
import UIKit

typealias MultiSectionListSnapshot = NSDiffableDataSourceSnapshot<MenuSection, MenuDataType>
typealias MultiSectionListDataSource = UICollectionViewDiffableDataSource<MenuSection, MenuDataType>

class MultiSectionListCollectionView: UICollectionView {
    
    var datasource: MultiSectionListDataSource!
    
    let data = [
        
        MenuSection(title: "Collection View List", menuList: [
            ListItem(type: .singleSectionList),
            ListItem(type: .multiSectionList)
        ]),
        
        MenuSection(title: "Grid", menuList: [
            ListItem(type: .gridLayout),
            ListItem(type: .waterfallLayout)
        ])
        
    ]
    
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        delegate = self
        setCollectionViewLayout(layout(), animated: false)
        configureDataSource()
        performUpdates()
    }
    
    func configureDataSource(){
        
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MenuSection> { (cell, indexPath, headerItem) in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure(options: UICellAccessory.OutlineDisclosureOptions(style: .header))]
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem> { (cell, indexPath, listItem) in
            var content = cell.defaultContentConfiguration()
            content.image = listItem.image
            content.text = listItem.title
            cell.contentConfiguration = content
        }
        
        datasource = UICollectionViewDiffableDataSource<MenuSection, MenuDataType>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch item {
            case .header(let headerItem):
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: headerItem)
                
            case .list(let listItem):
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: listItem)
            }
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .firstItemInSection
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func performUpdates(){
        var snapshot = MultiSectionListSnapshot()
        
        snapshot.appendSections(data)
        datasource.apply(snapshot)
        
        data.forEach { item in
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<MenuDataType>()
            
            let section = MenuDataType.header(item)
            sectionSnapshot.append([section])
            
            let listItemArray = item.menuList.map { MenuDataType.list($0) }
            sectionSnapshot.append(listItemArray, to: section)
            sectionSnapshot.expand([section])
            
            datasource.apply(sectionSnapshot, to: item, animatingDifferences: false)
        }
    }
    
}

extension MultiSectionListCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = datasource.itemIdentifier(for: indexPath) else {return}
        
        switch item {
        case .list(let listItem):
            print("?? listItem : ", listItem.title)
        default:
            break
        }
        
    }
    
}
