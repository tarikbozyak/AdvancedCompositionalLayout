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
            titleLabel.textColor = titleTextColor
            layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = titleTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "<title>"
        return label
    }()
    
    var titleTextColor: UIColor? {
        return isSelected ? .link : .link.withAlphaComponent(0.7)
    }
    
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
        fatalError("MenuCell coder has not been implemented")
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
        layer.borderWidth = isSelected ? 2.0 : 0
        layer.borderColor = UIColor.link.cgColor
    }
}
