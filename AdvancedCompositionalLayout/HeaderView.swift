//
//  HeaderView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 17.06.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGreen
        addTitle()
    }
    
    func addTitle(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("HeaderView init(coder:) has not been implemented")
    }
    
    func configure(with item: String) {
        titleLabel.text = item
    }
        
}
