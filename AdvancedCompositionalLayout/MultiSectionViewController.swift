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
        
        Section(title: "Person List", data: Person.defaultData, cellType: PersonCell.self, layout: { _, _,_,_   in
            let layout: NSCollectionLayoutSection = .personSection()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Task Caption", data: Task.defaultData, cellType: TaskCell.self, footerType: PagerFooterView.self, layout: { sectionIndex, _,_,pageListener   in
            let layout: NSCollectionLayoutSection = .taskCaptionSection()
            layout.addHeader()
            layout.addPagerFooter()
            layout.addVisibleItemsHandler(with: pageListener, sectionIndex: sectionIndex)
            return layout
        }),
        
        Section(title: "Task Statistics", data: TaskStatistics.defaultData, cellType: TaskStatisticsCell.self, layout: { _,_,_,_   in
            let layout: NSCollectionLayoutSection = .taskStatisticsSection()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 1", data: [Int](1...70), cellType: NestedCell.self, layout: { _,_,_,_   in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout1()
            layout.addHeader()
            layout.addFooter()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 2", data: [Int](71...130), cellType: NestedCell.self, layout: { _,_,_,_   in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout2()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Horizontal Nested Group Layout 3", data: [Int](131...200), cellType: NestedCell.self, layout: { _,_,_,_   in
            let layout: NSCollectionLayoutSection = .horizontalNestedGroupLayout3()
            layout.addHeader()
            return layout
        }),
        
        Section(title: "Vertical Waterfall Layout", data: [Int](201...240), cellType: WaterfallCell.self, layout: { _,environment, dataCount, _   in
            let config = WaterfallConfiguration(dataCount: dataCount, columnCount: 2, itemSpacing: 10, sectionHorizontalSpacing: 3, itemHeightProvider: { CGFloat.random(in: 250...500) }, environment: environment)
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

