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
        
        Person(name: "Hasan", surname: "Yerlikaya", job: "Director", imageName: "user1"),
        Person(name: "Mehmet", surname: "Günsur", job: "iOS Developer", imageName: "user2"),
        Person(name: "Halim", surname: "Üstündağ", job: "Android Developer", imageName: "user3"),
        Person(name: "Meltem", surname: "Şekik", job: "UI Designer", imageName: "user4"),
        Person(name: "Kürşat", surname: "Oğuz", job: "Project Owner", imageName: "user5"),
        Person(name: "Sergen", surname: "Ekmekçi", job: "Front-End Developer", imageName: "user6"),
        Person(name: "Serhat", surname: "İhsanoğlu", job: "Backend Developer", imageName: "user7"),
        Person(name: "Metin", surname: "Dedeli", job: "Assistant", imageName: "user8"),
        Person(name: "Leyla", surname: "Perdeci", job: "Web Developer", imageName: "user9"),
        Person(name: "Ömer", surname: "Gallavi", job: "Lawyer", imageName: "user10"),
        Person(name: "Selim", surname: "Uncu", job: "Project Owner", imageName: "user11"),
        Person(name: "Adem", surname: "Ekşi", job: "Accountant", imageName: "user12")
        
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
