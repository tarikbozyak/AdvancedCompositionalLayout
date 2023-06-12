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
    
    let sectionData = [
        
        Person(name: "Hasan", surname: "Yerlikaya"),
        Person(name: "Mehmet", surname: "Günsur"),
        Person(name: "Halim", surname: "Üstündağ"),
        Person(name: "Kürşat", surname: "Oğuz"),
        Person(name: "Meltem", surname: "Şekik"),
        Person(name: "Sergen", surname: "Ekmekçi"),
        Person(name: "Serhat", surname: "İhsanoğlu"),
        Person(name: "Menekşe", surname: "Dedeli"),
        Person(name: "Leyla", surname: "Perdeci"),
        Person(name: "Ömer", surname: "Gallavi"),
        Person(name: "Selim", surname: "Uncu"),
        Person(name: "Funda", surname: "Ekşi"),
        
    ]
    
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
