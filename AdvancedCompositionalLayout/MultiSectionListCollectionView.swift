//
//  MultiSectionListCollectionView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.04.2023.
//

import Foundation
import UIKit

typealias MultiSectionListSnapshot = NSDiffableDataSourceSnapshot<MenuHeaderItem, ListSection>
typealias MultiSectionListDataSource = UICollectionViewDiffableDataSource<MenuHeaderItem, ListSection>

class MultiSectionListCollectionView: UICollectionView {
    
    var datasource: MultiSectionListDataSource!
    
    let data = [
        
        MenuHeaderItem(title: "Collection View List", items: [
            MenuListItem(type: .singleSectionList),
            MenuListItem(type: .multiSectionList)
        ]),
        
        MenuHeaderItem(title: "Grid", items: [
            MenuListItem(type: .gridLayout),
            MenuListItem(type: .waterfallLayout)
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
        
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MenuHeaderItem> { (cell, indexPath, headerItem) in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure(options: UICellAccessory.OutlineDisclosureOptions(style: .header))]
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MenuListItem> { (cell, indexPath, symbolItem) in
            var content = cell.defaultContentConfiguration()
            content.image = symbolItem.image
            content.text = symbolItem.title
            cell.contentConfiguration = content
        }
        
        datasource = UICollectionViewDiffableDataSource<MenuHeaderItem, ListSection>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch item {
            case .headerCell(let headerItem):
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: headerItem)
                
            case .listCell(let symbolItem):
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: symbolItem)
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
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListSection>()
            
            let headerListItem = ListSection.headerCell(item)
            sectionSnapshot.append([headerListItem])
            
            let symbolListItemArray = item.items.map { ListSection.listCell($0) }
            sectionSnapshot.append(symbolListItemArray, to: headerListItem)
            sectionSnapshot.expand([headerListItem])
            
            datasource.apply(sectionSnapshot, to: item, animatingDifferences: false)
        }
    }
    
}

extension MultiSectionListCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = datasource.itemIdentifier(for: indexPath) else {return}
        
        switch item {
        case .listCell(let menuListItem):
            print("?? menuListItem : ", menuListItem.title)
        default:
            break
        }
        
    }
    
}
