//
//  TaskCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 19.06.2023.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var estimatedTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy  var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cardBackgroundImage2")
        return imageView
    }()
    
    lazy var facePileView: FacePileView = {
        let facePileView = FacePileView()
        facePileView.imageDiameter = 40
        facePileView.overlap = 30
        facePileView.translatesAutoresizingMaskIntoConstraints = false
        return facePileView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layerConfigure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layerConfigure()
        addSubview(imageView)
        imageView.edgesToSuperview()
        addSubview(titleLabel)
        addSubview(estimatedTime)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            estimatedTime.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            estimatedTime.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("GridCell coder has not been implemented")
    }
    
    func configure(with item: Task) {
        titleLabel.text = item.name
        estimatedTime.text = "Estimated time is " + item.estimated
        facePileView.profileImages = item.personList.map{UIImage(named: $0.imageName)}
        facePileView.setupView()
        addSubview(facePileView)
        NSLayoutConstraint.activate([
            facePileView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            facePileView.bottomAnchor.constraint(equalTo: estimatedTime.bottomAnchor, constant: 16)
        ])
    }
    
    func layerConfigure(){
        let isLandscape = frame.width / frame.height > 1 ? true : false
        let cornerRadius = isLandscape ? frame.height / 10 : frame.width / 10
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
