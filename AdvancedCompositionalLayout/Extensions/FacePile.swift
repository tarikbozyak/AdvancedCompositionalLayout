//
//  FacePile.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 19.06.2023.
//

import UIKit

class FacePileView: UIView {
    var profileImages: [UIImage?] = []
    var imageDiameter: CGFloat = 50
    var overlap: CGFloat = 30
    var borderColor: UIColor = .white

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        for (index, image) in profileImages.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageDiameter / 2
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = 1
            imageView.frame = CGRect(x: CGFloat(index) * overlap, y: 0, width: imageDiameter, height: imageDiameter)
            addSubview(imageView)
        }
    }
}
