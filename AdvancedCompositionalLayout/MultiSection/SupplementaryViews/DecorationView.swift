//
//  DecorationView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.07.2023.
//

import Foundation
import UIKit

class DecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        backgroundColor = UIColor(named: "section10CellColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("DecorationView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
        
}

