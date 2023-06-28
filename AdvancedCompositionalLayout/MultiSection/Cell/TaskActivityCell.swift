//
//  TaskActivityCell.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.06.2023.
//

import Foundation
import UIKit

class TaskActivityCell: UICollectionViewCell {
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, descriptionStackView, progressStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // Title Stack
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, moreButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.text = "<title>"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    // Description Stack
    lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facePileView, dateStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        return stackView
    }()
    
    lazy var facePileView: FacePileView = {
        let facePileView = FacePileView()
        facePileView.imageDiameter = 30
        facePileView.overlap = 24
        facePileView.translatesAutoresizingMaskIntoConstraints = false
        facePileView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return facePileView
    }()
    
    //Date
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateImageView, dateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.7)
        label.text = "<date>"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return imageView
    }()
    
    lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [progressLabel, progressView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white.withAlphaComponent(0.85)
        label.text = "0%"
        label.numberOfLines = 1
        return label
    }()
    
        
    lazy var progressView: CustomProgressView = {
        let progressView = CustomProgressView(type: .line)
        progressView.progressColor = .white
        progressView.trackColor = .systemGray5.withAlphaComponent(0.5)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layerConfigure()
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
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func configure(with item: Task) {
        titleLabel.text = item.title
        dateLabel.text = item.dueDate
        progressLabel.text = String(Int(item.progress * 100)) + "%"
        progressView.progress = item.progress
        facePileView.profileImages = item.personList.map{UIImage(named: $0.imageName)}
        facePileView.setupView()
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
    
    @objc func moreButtonTapped(){
        print("More button tapped..")
    }
}
