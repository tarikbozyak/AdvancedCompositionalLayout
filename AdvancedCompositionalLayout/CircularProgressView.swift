//
//  CircularProgressView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import UIKit

class CircularProgressView: UIView {
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()

    var progress: CGFloat = 0 {
        didSet{
            var pathMoved = progress - oldValue
            if pathMoved < 0{
                pathMoved = 0 - pathMoved
            }
            
            progressLabel.text = String(Int(progress * 100)) + "%"
            updateProgress(duration: timeToFill * Double(pathMoved), to: progress)
        }
    }
    
    var progressColor = UIColor.blue {
        didSet{
            progressLayer.strokeColor = progressColor.cgColor
            progressLabel.textColor = progressColor.withAlphaComponent(0.8)
        }
    }

    var trackColor = UIColor.systemGray3 {
        didSet{
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemBlue.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeToFill = 3.43

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }

    private func setupLayers() {
        // Create the track layer
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 8.0
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        // Create the progress layer
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 8.0
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = CGFloat(progress)
        layer.addSublayer(progressLayer)
        
        self.addSubview(progressLabel)
        progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Update the path of the layers based on the view's bounds
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = frame.width / 2

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)

        trackLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }

    func updateProgress(duration: TimeInterval = 3, to newProgress: CGFloat) -> Void{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = newProgress
        
        progressLayer.strokeEnd = newProgress
        
        progressLayer.add(animation, forKey: "animationProgress")
        
    }
}


