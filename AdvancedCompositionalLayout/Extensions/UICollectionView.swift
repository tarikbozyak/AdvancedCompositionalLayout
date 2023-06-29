//
//  UICollectionView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 28.06.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setLoading(){
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .gray
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
    }
    
    func clear() {
        subviews.forEach { view in
            if let activityIndicatorView = view as? UIActivityIndicatorView {
                activityIndicatorView.removeConstraints(activityIndicatorView.constraints)
                activityIndicatorView.removeFromSuperview()
            }
            
            if let stackView = view as? UIStackView {
                stackView.removeAllArrangedSubviews()
                stackView.removeConstraints(stackView.constraints)
                stackView.removeFromSuperview()
            }
        }
    }
    
    func setErrorMessage(_ error: Error?, recognizer: UITapGestureRecognizer?) {
        //image
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.clockwise.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //label
        let messageLabel = UILabel()
        messageLabel.text = "List couldn't load. \n Try again"
        messageLabel.textColor = .systemGray2
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        messageLabel.sizeToFit()
        
        //stack view
        let stackView = UIStackView(arrangedSubviews: [imageView, messageLabel])
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.widthAnchor.constraint(equalToConstant: bounds.width - 100).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if let recognizer = recognizer {
            stackView.addGestureRecognizer(recognizer)
        }
        
    }
    
    
    
}
