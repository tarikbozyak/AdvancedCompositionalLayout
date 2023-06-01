//
//  WaterfallCell.swift
//  AdvancedCompositionalLayout
//
//  Created by AHMED TARIK BOZYAK on 22.05.2023.
//

import Foundation
import UIKit

class WaterfallCell: UICollectionViewCell {
    
    var type: WaterfallType?
    
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
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("GridCell coder has not been implemented")
    }
    
    func configure(with item: Int, type: WaterfallType) {
        self.type = type
        textLabel.text = String(item)
    }
    
    func layerConfigure(){
        
        let cornerRadius = type == .vertical ? frame.width / 10 : frame.height / 2
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
