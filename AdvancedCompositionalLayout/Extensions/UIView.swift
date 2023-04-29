//
//  UIView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 29.04.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func edgesToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ])
    }
    
    func edgesToSuperviewSafeLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func edgesToSuperviewBoundsWithAutoResizingMask() {
        translatesAutoresizingMaskIntoConstraints = true
        frame = superview!.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
