//
//  GridViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.05.2023.
//

import Foundation
import UIKit

class GridViewController: UIViewController {
    
    var maxColumnCount = 5
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Standard item", image: UIImage(systemName: "sun.max"), handler: { (_) in
                print("Standart Item")
            }),
        ]
    }
    
    let sectionData = [Int](1...100)
    
    lazy var collectionView = Grid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureNavigationBar(){
        let menuItems1 = (1...maxColumnCount).map({UIAction(title: "\($0)x\($0)", handler: { [weak self] action in
            self?.setColumnCount(Int(String(action.title.first!)) ?? 0)
        })})
        let menu = UIMenu(title: "Column Count", image: nil, identifier: nil, options: [], children: menuItems1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.dashed"), primaryAction: nil, menu: menu)
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
    
    private func setColumnCount(_ item: Int){
        print("?? columncount : \(item)")
        collectionView.columnCount = item
        collectionView.reloadData()
    }
}

extension GridViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}

