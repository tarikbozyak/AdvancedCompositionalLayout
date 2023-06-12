//
//  MultiSectionListCollectionView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.04.2023.
//

import Foundation
import UIKit

typealias MultiSectionListSnapshot = NSDiffableDataSourceSnapshot<Int, ListItem>
typealias MultiSectionListDataSource = UICollectionViewDiffableDataSource<Int, ListItem>

protocol CollectionViewDataDelegte: AnyObject {
    func data() -> [AnyHashable]
}

class MultiSectionExpandableList: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: MultiSectionListDataSource!
    var style: UICollectionLayoutListConfiguration.Appearance = .grouped
    
    var data: [ListItem] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [ListItem] ?? []
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
        
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem> { (cell, indexPath, headerItem) in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            if indexPath.row != 0 {
                content.textProperties.font = .preferredFont(forTextStyle: .callout)
                content.textProperties.color = .label
                cell.accessories = [.outlineDisclosure(options: UICellAccessory.OutlineDisclosureOptions(style: .header)), .label(text: "\(headerItem.subItems.count) items")]
            }
            else {
                content.textProperties.font = .preferredFont(forTextStyle: .headline)
                cell.accessories = [.outlineDisclosure(options: UICellAccessory.OutlineDisclosureOptions(style: .header))]
            }
            cell.contentConfiguration = content
            
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem> { (cell, indexPath, listItem) in
            var content = cell.defaultContentConfiguration()
            content.text = listItem.title
            content.textProperties.font = .preferredFont(forTextStyle: .callout)
            content.textProperties.color = .label
            cell.contentConfiguration = content
        }
        
        datasource = UICollectionViewDiffableDataSource<Int, ListItem>(collectionView: self) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let cellRegistration = {
                return item.subItems.isEmpty ? listCellRegistration : headerCellRegistration
            }()
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.headerMode = .firstItemInSection
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func performUpdates() {
        var snapshot = MultiSectionListSnapshot()
        let sections = [Int](0...data.count)
        snapshot.appendSections(sections)
        datasource.apply(snapshot)
        
        data.enumerated().forEach { index, item in
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            sectionSnapshot.append([item])
            sectionSnapshot.append(item.subItems, to: item)
            sectionSnapshot.expand([item])
            
            item.subItems.forEach { subItem in
                if !subItem.subItems.isEmpty{
                    sectionSnapshot.append(subItem.subItems, to: subItem)
                    subItem.subItems.forEach { subItem in
                        if !subItem.subItems.isEmpty{
                            sectionSnapshot.append(subItem.subItems, to: subItem)
                        }
                    }
                }
            }
            
            datasource.apply(sectionSnapshot, to: index, animatingDifferences: false)
        }
    }
    
}

extension MultiSectionExpandableList: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource.itemIdentifier(for: indexPath) else {return}
        guard let viewController = item.type?.viewController else {return}
        rootVC.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
