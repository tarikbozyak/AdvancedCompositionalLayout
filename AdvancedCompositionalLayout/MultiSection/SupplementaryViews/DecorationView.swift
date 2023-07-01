//
//  DecorationView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 1.07.2023.
//

import Foundation
import UIKit

// MARK: GradientDecorationView1
class GradientDecorationView1: UICollectionReusableView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "gradient7")
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
        layerConfigure()
    }
    
    func layerConfigure(){
        imageView.layer.masksToBounds = true
    }
        
}

// MARK: GradientDecorationView2
class GradientDecorationView2: UICollectionReusableView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "gradient6")
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
        layerConfigure()
    }
    
    func layerConfigure(){
        imageView.layer.masksToBounds = true
    }
        
}

// MARK: GradientDecorationView3
class GradientDecorationView3: UICollectionReusableView {
    
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
        layerConfigure()
    }
    
    func layerConfigure(){
        imageView.layer.masksToBounds = true
    }
        
}
