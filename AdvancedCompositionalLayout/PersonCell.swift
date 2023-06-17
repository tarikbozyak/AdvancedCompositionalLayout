//
//  PersonCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 17.06.2023.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .gray.withAlphaComponent(0.8)
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.layer.cornerRadius = frame.width / 2
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NestedCell coder has not been implemented")
    }
    
    func configure(with item: Person) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
    }
    
}
