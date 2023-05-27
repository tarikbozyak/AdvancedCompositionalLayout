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

protocol CollectionViewDataDelegte: AnyObject {
    func data() -> [AnyHashable]
}

class MultiSectionExpandableList: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: MultiSectionListDataSource!
    var style: UICollectionLayoutListConfiguration.Appearance = .grouped
    
    var data: [MenuSection] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [MenuSection] ?? []
    }
    
    init(frame: CGRect = .zero, style: UICollectionLayoutListConfiguration.Appearance = .grouped) {
        self.style = style
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

extension MultiSectionExpandableList: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = datasource.itemIdentifier(for: indexPath) else {return}
        
        switch item {
        case .list(let listItem):
            if listItem.type == .simpleList {
                rootVC.navigationController?.pushViewController(SimpleListViewController(), animated: true)
            }
            else if listItem.type == .supplementary {
                rootVC.navigationController?.pushViewController(SupplementaryViewController(), animated: true)
            }
            else if listItem.type == .gridLayout {
                rootVC.navigationController?.pushViewController(GridViewController(), animated: true)
            }
            else if listItem.type == .waterfallLayout {
                rootVC.navigationController?.pushViewController(WaterfallViewController(), animated: true)
            }
            
        default:
            break
        }
        
    }
    
}
