//
//  BadgeSupplementaryView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import Foundation
import UIKit

class BadgeView: UICollectionReusableView {
    
    var personStatus: PersonStatus?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(status: PersonStatus?){
        self.personStatus = status
        configureLayout()
    }
    
    func configureLayout(){
        layer.cornerRadius = bounds.height/2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.5
        backgroundColor = personStatus == .online ? .systemGreen : .systemRed
    }
}

