//
//  MultiSectionViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

class MultiSectionViewController: UIViewController {
    
    lazy var collectionView = MultiSection()
    
    let sectionData = [
        Section(data: [Int](1...10), cellType: GridCell.self, layout: { _ in
                .gridSection(columnCount: 2)
        }),
        
        Section(data: [Int](11...20), cellType: WaterfallCell.self, layout: { environment in
            let itemHeightProvider: ItemHeightProvider = { return CGFloat.random(in: 250...500) }
            let config = WaterfallConfiguration(dataCount: 10, columnCount: 2, itemSpacing: 10, sectionHorizontalSpacing: 16, itemHeightProvider: itemHeightProvider, environment: environment)
            return .verticalWaterfallSection(config: config)
        })
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
        title = "Multi Section"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray5
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension MultiSectionViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}

