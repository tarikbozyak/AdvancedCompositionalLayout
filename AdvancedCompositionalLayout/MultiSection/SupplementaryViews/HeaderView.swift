//
//  HeaderView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 17.06.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    var isBlurEffectActive: Bool?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        return blurVisualEffectView
    }()
    
    lazy var gradientLine: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor.red.cgColor, UIColor.systemYellow.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = [0, 0.5, 1]

        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp(){
        addSubview(backgroundView)
        addSubview(stackView)
        backgroundView.edgesToSuperview()
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("HeaderView init(coder:) has not been implemented")
    }
    
    func configure(with item: String) {
        titleLabel.text = item
        titleLabel.textColor = .link.withAlphaComponent(0.8)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.addSublayer(gradientLine)
        gradientLine.frame = CGRect(x: 0, y: frame.size.height - 3, width: frame.width, height: 3)
    }
        
}
