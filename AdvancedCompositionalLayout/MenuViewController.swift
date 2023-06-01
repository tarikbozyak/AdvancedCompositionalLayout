//
//  MenuViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 23.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var collectionView = MultiSectionExpandableList()
    
    let sectionData = [
        
        MenuSection(title: "Grid", menuList: [
            ListItem(type: .gridLayout),
            ListItem(type: .waterfallLayout),
            ListItem(type: .horizontalWaterfallLayout)
        ]),
        
        MenuSection(title: "Collection View List", menuList: [
            ListItem(type: .simpleList),
            ListItem(type: .supplementary),
            ListItem(type: .multiSectionList)
        ])
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationBar()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
    
    private func configureNavigationBar(){
        title = "Menu"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray5
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension MenuViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}
