//
//  CustomProgressView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import UIKit

enum ProgressViewType {
    case line
    case circular
}

class CustomProgressView: UIView {
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    let type: ProgressViewType
    
    var lineWidth: CGFloat {
        return type == .circular ? 6 : 8
    }

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
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemBlue.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeToFill = 3.43

    init(frame: CGRect = .zero, type: ProgressViewType) {
        self.type = type
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("CustomProgressView Not implemented..")
    }

    private func setupLayers() {
        // Create the track layer
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        // Create the progress layer
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = CGFloat(progress)
        layer.addSublayer(progressLayer)
        
        // Progress Label
        addProgressLabel()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(shapeLayer: trackLayer)
        setupShapeLayer(shapeLayer: progressLayer)
    }
    
    func setupShapeLayer(shapeLayer: CAShapeLayer) {
        
        switch type {
        case .line:
            shapeLayer.frame = self.bounds
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: 0, y: bounds.midY))
            linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
            shapeLayer.path = linePath.cgPath
        case .circular:
            let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            let radius = frame.width / 2
            let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
            shapeLayer.path = circularPath.cgPath
        }
    }
    
    func addProgressLabel(){
        switch type {
            
        case .circular:
            self.addSubview(progressLabel)
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        default: break
            
        }
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


