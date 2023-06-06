//
//  NestedViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 5.06.2023.
//

import Foundation
import UIKit

class NestedViewController: UIViewController {
    
    lazy var collectionView = NestedGroup()
    
    let sectionData = [Int](1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
    
    private func setColumnCount(_ item: Int){
        collectionView.columnCount = item
        collectionView.reloadData()
    }
}

extension NestedViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}
