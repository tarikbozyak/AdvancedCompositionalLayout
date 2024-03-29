//
//  PagerFooterView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import UIKit
import Combine

class PagerFooterView: UICollectionReusableView {
    
    var cancellable: AnyCancellable?
    var delegate: PagerDelegate?
    var indexPath: IndexPath!
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .systemGray5
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundStyle = .prominent
        control.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return control
    }()
    
    @objc func valueChanged(sender: UIPageControl) {
        let currentValue = sender.currentPage
        delegate?.didValueChanged(indexPath: IndexPath(item: currentValue, section: indexPath.section), scrollPosition: .centeredHorizontally)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(numberOfPages: Int, indexPath: IndexPath, delegate: PagerDelegate?) {
        self.indexPath = indexPath
        self.delegate = delegate
        pageControl.numberOfPages = numberOfPages
    }

    func subscribeTo(subject: PageListener, for section: Int) {
        cancellable = subject
            .removeDuplicates()
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pageInfo in
                self?.pageControl.currentPage = pageInfo.pageIndex
            }
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
        cancellable = nil
    }
}
