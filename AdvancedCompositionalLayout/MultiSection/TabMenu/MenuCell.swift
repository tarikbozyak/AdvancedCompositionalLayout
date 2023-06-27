//
//  MenuCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import UIKit

class MenuCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .systemGray6 : .systemPurple
            backgroundColor = isSelected ? .systemPurple : .clear
            layer.borderWidth = isSelected ? 0 : 2
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = isSelected ? .systemGray6 : .systemPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "<title>"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layerConfigure()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layerConfigure()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GridCell coder has not been implemented")
    }
    
    func setupView(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with item: Menu) {
        titleLabel.text = item.title
    }
    
    func layerConfigure(){
        let cornerRadius = frame.height / 2
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemGreen.cgColor
    }
}
