//
//  GridCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.05.2023.
//

import Foundation
import UIKit

class GridCell: UICollectionViewCell {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layerConfigure()
        addSubview(textLabel)
        textLabel.edgesToSuperview()
        backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("GridCell coder has not been implemented")
    }
    
    func configure(with item: Int) {
        textLabel.text = String(item)
    }
    
    func layerConfigure(){
        let cornerRadius = frame.width / 10
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
    }
}
