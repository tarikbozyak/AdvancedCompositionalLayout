//
//  MenuViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 23.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var collectionView = MultiSectionExpandableList()
    
    let sectionData = ListItem.defaultData
    
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
