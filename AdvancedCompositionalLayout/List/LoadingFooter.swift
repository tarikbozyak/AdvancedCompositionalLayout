//
//  LoadingFooter.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 29.06.2023.
//

import Foundation
import UIKit
import Combine

protocol LoadingDelegate: AnyObject {
    func retry()
}

enum LoadingStatus {
    case loading
    case retry
    case allDone
}

class LoadingFooter: UICollectionReusableView {
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: LoadingDelegate?
    
    var nextPagination: String?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    func setupView(){
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("LoadingCell coder has not been implemented")
    }
    
    func configure(status: LoadingStatus) {
        
        stackView.removeAllArrangedSubviews()
        
        switch status {
        case .loading:
            loadingIndicator.startAnimating()
            stackView.addArrangedSubview(loadingIndicator)
            stackView.addArrangedSubview(getStatusLabel("Loading"))
        case .retry:
            stackView.addArrangedSubview(retryButton)
            stackView.addArrangedSubview(getStatusLabel("Retry"))
        case .allDone:
            loadingIndicator.stopAnimating()
            stackView.addArrangedSubview(getStatusLabel("All Done", textColor: .systemGray3))
        }
        
    }
    
    func subscribeTo(isLoading: Published<Bool>.Publisher ,isSuccessfullyLoaded: PassthroughSubject<Bool,Never>) {
        
        isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .filter{$0}
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                self.configure(status: .loading)
            }
            .store(in: &cancellables)
        
        
        isSuccessfullyLoaded
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccess in
                guard let self = self else { return }
                if !isSuccess {
                    self.configure(status: .retry)
                }
                else if isSuccess && self.nextPagination == nil {
                    self.configure(status: .allDone)
                }
            }
            .store(in: &cancellables)
            
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.removeAllArrangedSubviews()
    }
    
    func getStatusLabel(_ text: String, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = textColor.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    @objc func retryButtonTapped() {
        delegate?.retry()
    }
    
}


