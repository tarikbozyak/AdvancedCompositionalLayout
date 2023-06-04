//
//  WaterfallCell.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

class WaterfallCell: UICollectionViewCell {
    
    var cornerRadius: CGFloat?
    
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
        fatalError("GridCell coder has not been implemented")
    }
    
    func configure(with item: Int, bgColor: UIColor?, cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = bgColor?.withAlphaComponent(0.7)
        textLabel.text = String(item)
    }
    
    func layerConfigure(){
        
        contentView.layer.cornerRadius = cornerRadius ?? 0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius ?? 0
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
    }
}
