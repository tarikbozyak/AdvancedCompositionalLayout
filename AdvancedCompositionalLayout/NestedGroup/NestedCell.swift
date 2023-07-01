//
//  NestedCell.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 10.06.2023.
//

import Foundation
import UIKit

class NestedCell: UICollectionViewCell {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layerConfigure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layerConfigure()
        addSubview(textLabel)
        textLabel.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NestedCell coder has not been implemented")
    }
    
    func configure(with item: Int) {
        textLabel.text = String(item)
    }
    
    func layerConfigure(){
//        let isLandscape = frame.width / frame.height > 1 ? true : false
//        let cornerRadius = isLandscape ? frame.height / 10 : frame.width / 10
//        contentView.layer.cornerRadius = cornerRadius
//        contentView.layer.masksToBounds = true
//        layer.cornerRadius = cornerRadius
//        layer.masksToBounds = false
//        layer.shadowRadius = 8.0
//        layer.shadowOpacity = 0.10
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 5)
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.systemGray5.cgColor
    }
}

