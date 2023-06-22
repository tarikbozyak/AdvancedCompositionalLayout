//
//  HeaderView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 17.06.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
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
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        return blurVisualEffectView
    }()
    
    private let blurEffect = UIBlurEffect(style: .systemThinMaterial)
    
    lazy var gradientLineView: GradientLineView = {
        let gradientView = GradientLineView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .systemGray4.withAlphaComponent(0.7)
        setUp()
    }
    
    func setUp(){
        addSubview(backgroundView)
        addSubview(stackView)
        addSubview(gradientLineView)
        backgroundView.edgesToSuperview()
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: gradientLineView.topAnchor, constant: -10),
            gradientLineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientLineView.leftAnchor.constraint(equalTo: leftAnchor),
            gradientLineView.rightAnchor.constraint(equalTo: rightAnchor),
            gradientLineView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("HeaderView init(coder:) has not been implemented")
    }
    
    func configure(with item: String) {
        titleLabel.text = item
        titleLabel.textColor = .link.withAlphaComponent(0.8)
    }
        
}
