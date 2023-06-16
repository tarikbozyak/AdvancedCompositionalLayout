//
//  SupplementaryViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.05.2023.
//

import Foundation
import UIKit

class SupplementaryViewController: UIViewController {
    
    lazy var collectionView = Supplementary()
    
    let sectionData = Country.defaultSectionData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Header & Footer"
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
}

extension SupplementaryViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}
