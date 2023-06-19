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
        
        Section(title: "Person List", data: Person.defaultData, cellType: PersonCell.self, layout: { _, _ in
            let layout: NSCollectionLayoutSection = .personSection()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Task Caption", data: Task.defaultData, cellType: TaskCell.self, layout: { _, _ in
            let layout: NSCollectionLayoutSection = .taskCaptionSection()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 1", data: [Int](1...70), cellType: NestedCell.self, layout: { _, _ in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout1()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 2", data: [Int](71...130), cellType: NestedCell.self, layout: { _, _ in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout2()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 3", data: [Int](131...200), cellType: NestedCell.self, layout: { _, _ in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout3()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Waterfall Layout", data: [Int](201...270), cellType: WaterfallCell.self, layout: { environment, dataCount in
            let itemWidthProvider: ItemWidthProvider = { return CGFloat.random(in: 150...300) }
            let config = WaterfallConfiguration(dataCount: dataCount, rowCount: 4, itemSpacing: 3, sectionVerticalSpacing: 12, itemWidthProvider: { CGFloat.random(in: 100...200)}, sectionHeight: .fractionalHeight(0.25), environment: environment)
            let layout: NSCollectionLayoutSection = .horizontalWaterfallSection(config: config)
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Vertical Waterfall Layout", data: [Int](271...300), cellType: WaterfallCell.self, layout: { environment, dataCount in
            let config = WaterfallConfiguration(dataCount: dataCount, columnCount: 4, itemSpacing: 10, sectionHorizontalSpacing: 3, itemHeightProvider: { CGFloat.random(in: 250...500) }, environment: environment)
            let layout: NSCollectionLayoutSection = .verticalWaterfallSection(config: config)
            layout.addHeader()
            return layout
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

