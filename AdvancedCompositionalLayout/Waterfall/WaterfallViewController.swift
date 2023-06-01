//
//  WaterfallViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

class WaterfallViewController: UIViewController {
    
    lazy var collectionView = Waterfall()
    
    let sectionData = [Int](1...100)
    
    var maxColumnCount = 5
    var maxRowCount = 8
    
    var type: WaterfallType = .vertical
    
    init(type: WaterfallType = .vertical) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.type = type
        collectionView.rootVC = self
        collectionView.performUpdates()
    }
    
    private func configureNavigationBar(){
        var menuItems: [UIAction] = []
        var menuTitle: String = ""
        
        switch type {
        case .horizontal:
            menuTitle = "Row Count"
            menuItems = (4...maxRowCount).map({UIAction(title: "\($0)", handler: { [weak self] action in
                let firstCharacter = String(action.title.first!)
                self?.setColumnCount(Int(firstCharacter) ?? 0)
            })})
        case .vertical:
            menuTitle = "Column Count"
            menuItems = (2...maxColumnCount).map({UIAction(title: "\($0)x\($0)", handler: { [weak self] action in
                let firstCharacter = String(action.title.first!)
                self?.setColumnCount(Int(firstCharacter) ?? 0)
            })})
        }
        
        let menu = UIMenu(title: menuTitle, image: nil, identifier: nil, options: [], children: menuItems)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.dashed"), primaryAction: nil, menu: menu)
    }
    
    private func setColumnCount(_ item: Int){
        collectionView.columnCount = item
        collectionView.rowCount = item
        collectionView.reloadData()
    }
}

extension WaterfallViewController: CollectionViewDataDelegte {
    func data() -> [AnyHashable] {
        return sectionData
    }
}
