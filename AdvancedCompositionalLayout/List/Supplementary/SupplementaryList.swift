//
//  MenuCollectionView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 24.05.2023.
//

import Foundation
import UIKit

typealias CountrySnapshot = NSDiffableDataSourceSnapshot<CountrySection, Country>
typealias CountryDataSource = UICollectionViewDiffableDataSource<CountrySection, Country>
typealias SupplementaryListCell = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>

class SupplementaryList: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: CountryDataSource!
    var style: UICollectionLayoutListConfiguration.Appearance = .grouped
    
    var headerRegistration: SupplementaryListCell!
    var footerRegistration: SupplementaryListCell!
    
    var data: [CountrySection] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [CountrySection] ?? []
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
    
    private func commonInit(){
        delegate = self
        setCollectionViewLayout(layout(), animated: false)
        configureDataSource()
        configureSupplementaryViews()
    }
    
    private func configureDataSource(){
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Country> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = "\(item.flag)  \(item.name)"
            cell.contentConfiguration = content
        }
        
        datasource = .init(collectionView: self, cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
    }
    
    private func configureSupplementaryViews(){
        
        headerRegistration = .init(elementKind: UICollectionView.elementKindSectionHeader) { [unowned self]
            (header, elementKind, indexPath) in
            var configuration = header.defaultContentConfiguration()
            let headerItem = self.datasource.snapshot().sectionIdentifiers[indexPath.section]
            configuration.text = headerItem.title
            configuration.textProperties.transform = .none
            configuration.textProperties.font = .boldSystemFont(ofSize: 15)
            configuration.textProperties.color = .systemBlue
            header.contentConfiguration = configuration
        }
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter) { [unowned self]
            (footer, elementKind, indexPath) in
            var configuration = footer.defaultContentConfiguration()
            let itemCount = self.datasource.snapshot().sectionIdentifiers[indexPath.section].countryList.count
            configuration.text = "Item count: " + String(itemCount)
            footer.contentConfiguration = configuration
        }
        
        datasource.supplementaryViewProvider = supplementaryView
    }
    
    
    private func supplementaryView(in collection: UICollectionView, elementKind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return self.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        else {
            return self.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        configuration.footerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func performUpdates(){
        var snapshot = CountrySnapshot()
        snapshot.appendSections(data)
        data.forEach ({
            snapshot.appendItems($0.countryList, toSection: $0)
            datasource.apply(snapshot, animatingDifferences: false)
        })
    }
    
}

extension SupplementaryList: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
