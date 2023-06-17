//
//  MultiSection.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

typealias MultiSectionSnapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
typealias MultiSectionDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
typealias SupplementaryHeader = UICollectionView.SupplementaryRegistration<HeaderView>

class MultiSection: UICollectionView {
    
    weak var rootVC: UIViewController!
    
    var datasource: MultiSectionDataSource!
    
    var headerRegistration: SupplementaryHeader!
    
    var footerRegistration: SupplementaryListCell!
    
    var sectionList: [Section] {
        let delegate = rootVC as? CollectionViewDataDelegte
        return delegate?.data() as? [Section] ?? []
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
        configureSupplementaryViews()
    }
    
    func configureDataSource(){
        
        let nestedCellRegistration = UICollectionView.CellRegistration<NestedCell, Int> { (cell, _, item) in
            cell.configure(with: item)
        }
        
        let gridCellRegistration = UICollectionView.CellRegistration<GridCell, Int> { (cell, _, item) in
            cell.configure(with: item)
        }
        
        let waterfallCellRegistration = UICollectionView.CellRegistration<WaterfallCell, Int> { (cell, _, item) in
            cell.configure(with: item, bgColor: .systemBlue.withAlphaComponent(0.8), cornerRadius: 10)
        }
        
        datasource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: self) { [unowned self]
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let section = self.sectionList[indexPath.section]
            switch section.cellType {
                
            case is GridCell.Type:
                guard let data = section.data as? [Int] else {return nil}
                return collectionView.dequeueConfiguredReusableCell(using: gridCellRegistration, for: indexPath, item: data[indexPath.row])
                
            case is WaterfallCell.Type:
                guard let data = section.data as? [Int] else {return nil}
                return collectionView.dequeueConfiguredReusableCell(using: waterfallCellRegistration, for: indexPath, item: data[indexPath.row])
                
            case is NestedCell.Type:
                guard let data = section.data as? [Int] else {return nil}
                return collectionView.dequeueConfiguredReusableCell(using: nestedCellRegistration, for: indexPath, item: data[indexPath.row])
                
            default : return nil
            }
        }
    }
    
    private func configureSupplementaryViews(){
        
        headerRegistration = .init(elementKind: UICollectionView.elementKindSectionHeader) { [unowned self]
            (header, elementKind, indexPath) in
            let sectionTitle = self.datasource.sectionIdentifier(for: indexPath.section)?.title ?? ""
            header.configure(with: sectionTitle)
        }
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter) {
            (footer, elementKind, indexPath) in
            var configuration = footer.defaultContentConfiguration()
            configuration.text = "Item count: " + "Test"
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
    
    // MARK: Layout
    private func layout(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let dataCount = datasource.sectionIdentifier(for: sectionIndex)?.data.count ?? 1
        return sectionList[sectionIndex].layout(environment, dataCount)
    }
    
    // MARK: PerformUpdates
    func performUpdates(){
        var snapshot = MultiSectionSnapshot()
        sectionList.forEach({
            snapshot.appendSections([$0])
            snapshot.appendItems($0.data)
        })
        datasource.apply(snapshot,animatingDifferences: true)
    }
    
}

