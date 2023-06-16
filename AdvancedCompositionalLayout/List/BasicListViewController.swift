//
//  BasicListViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation
import UIKit

class BasicListViewController: UIViewController {
    
    lazy var collectionView = BasicList()
    
    let sectionData = Person.defaultData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic List"
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
}

extension BasicListViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}
