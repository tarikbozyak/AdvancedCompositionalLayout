//
//  DecorationView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.07.2023.
//

import Foundation
import UIKit

class DecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        backgroundColor = UIColor(named: "section10CellColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("DecorationView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
        
}

class DecorationView2: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        backgroundColor = .systemGray3
    }
    
    required init?(coder: NSCoder) {
        fatalError("DecorationView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
        
}

class DecorationView3: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("DecorationView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
        
}

class GradientDecorationView: UICollectionReusableView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "gradient1")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        addSubview(imageView)
        imageView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("DecorationView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
        
}

