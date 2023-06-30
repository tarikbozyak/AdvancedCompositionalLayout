//
//  LoadingFooter.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 29.06.2023.
//

import Foundation
import UIKit
import Combine

class LoadingFooter: UICollectionReusableView {
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func configure(isLoading: Bool, error: FetchError?) {
        
        stackView.removeAllArrangedSubviews()
        
        if error == nil {
            if isLoading {
                loadingIndicator.startAnimating()
                stackView.addArrangedSubview(loadingIndicator)
                stackView.addArrangedSubview(getStatusLabel("Loading"))
            }
            else {
                loadingIndicator.stopAnimating()
            }
        }
        else {
            stackView.addArrangedSubview(retryButton)
            stackView.addArrangedSubview(getStatusLabel("Retry"))
        }
    }
    
    func subscribeTo(isLoading: Published<Bool>.Publisher ,isSuccessfullyLoaded: PassthroughSubject<Bool,Never>) {
        
        isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                self.configure(isLoading: isLoading, error: nil)
            }
            .store(in: &cancellables)
        
        
        isSuccessfullyLoaded
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccess in
                guard let self = self else { return }
                if isSuccess {
                    self.configure(isLoading: false, error: nil)
                }
                else {
                    self.configure(isLoading: false, error: FetchError(description: "Loading error"))
                }
            }
            .store(in: &cancellables)
            
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.removeAllArrangedSubviews()
    }
    
    func getStatusLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    @objc func retryButtonTapped() {
//        delegate?.retry()
    }
    
}


