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
    
    let type: WaterfallType

    var sectionData: [WaterfallData] {
        var data = [WaterfallData]()
        [Int](1...100).forEach{data.append(.init(id: $0))}
        return data
    }
    
    var maxColumnCount = 5
    var maxRowCount = 8
    
    init(type: WaterfallType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("WaterfallViewController not implemented!")
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
            menuItems = (4...maxRowCount).map{UIAction(title: "\($0)", handler: { [weak self] action in
                let firstCharacter = String(action.title.first!)
                self?.setColumnCount(Int(firstCharacter) ?? 0)
            })}
        case .vertical:
            menuTitle = "Column Count"
            menuItems = (2...maxColumnCount).map{UIAction(title: "\($0)x\($0)", handler: { [weak self] action in
                let firstCharacter = String(action.title.first!)
                self?.setColumnCount(Int(firstCharacter) ?? 0)
            })}
        default:
            return
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
