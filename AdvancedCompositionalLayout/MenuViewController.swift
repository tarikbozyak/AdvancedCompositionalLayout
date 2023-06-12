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
        
        ListItem(title: "Grid", subItems: [
            ListItem(type: .gridLayout),
            ListItem(title: "Nested Groups", subItems: [
                ListItem(title: "Vertical Nested Groups", subItems: [
                    ListItem(type: .nestedGroup(type: .vertical))
                ]),
                ListItem(title: "Horizontal Nested Groups", subItems: [
                    ListItem(type: .nestedGroup(type: .horizontal(layoutId: 1))),
                    ListItem(type: .nestedGroup(type: .horizontal(layoutId: 2))),
                    ListItem(type: .nestedGroup(type: .horizontal(layoutId: 3)))
                ]),
            ]),
            ListItem(title: "Waterfall", subItems: [
                ListItem(type: .waterfall(type: .vertical)),
                ListItem(type: .waterfall(type: .horizontal)),
                ListItem(type: .waterfall(type: .stack))
            ])
        ]),
        
        ListItem(title: "Collection View List", subItems: [
            ListItem(type: .basicList),
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
