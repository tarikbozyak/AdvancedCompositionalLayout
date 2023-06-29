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
    
    weak var listDelegate: BasicListDelegate!
    
    var datasource: BasicListDataSource!
    
    var data: [Person] {
        let data = listDelegate?.data() ?? []
        let orderedData = NSOrderedSet(array: data).map({ $0 as! Person })
        return orderedData
    }
    
    var isRefreshing: Bool {
        return refreshControl?.isRefreshing ?? false
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
        delegate = self
        configureDataSource()
        addRefreshController()
    }
    
    private func addRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh(send: UIRefreshControl) {
        listDelegate?.refresh()
    }
    
    func configureDataSource(){
        
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Person> { (cell, indexPath, personItem) in
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(named: personItem.imageName.rawValue)
            content.imageProperties.maximumSize = .init(width: 60, height: 60)
            content.imageProperties.cornerRadius = 30
            content.text = personItem.fullName
            content.secondaryText = personItem.job.rawValue
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
    
    func performUpdates(isLoading: Bool = false){
        var snapshot = BasicListSnapshot()
        
        if isLoading, !isRefreshing {
            //
        }
        else {
            snapshot.appendSections([0])
            snapshot.appendItems(data)
        }
        datasource.apply(snapshot,animatingDifferences: true) { [weak self] in
            guard let self = self else {return}
            if self.contentSize.height < self.frame.size.height {
                self.listDelegate?.pagination()
            }
        }
    }
    
}

extension BasicList: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        let collectionViewContentSizeHeight = self.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if (position > (collectionViewContentSizeHeight - 150 - scrollViewHeight)) && collectionViewContentSizeHeight != scrollViewHeight && collectionViewContentSizeHeight > 0 {
            listDelegate?.pagination()
        }
    }
}
