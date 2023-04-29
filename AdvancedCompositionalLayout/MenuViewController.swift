//
//  MenuViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 23.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var collectionView = MultiSectionListCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureNavigationBar()
    }
    
    private func configureHierarchy(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
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
