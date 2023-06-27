//
//  TabHeaderView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import UIKit
import Combine

class TabHeaderView: UICollectionReusableView {
    
    var cancellable: AnyCancellable?
    weak var delegate: CollectionViewUpdate?
    var indexPath: IndexPath!
    
    var data: [Menu] = [] {
        didSet {
            guard data != oldValue else {return}
            tabMenu.data = data
            updateMenu()
        }
    }
    
    lazy var heightConstraint: NSLayoutConstraint = {
        let constaint = tabMenu.heightAnchor.constraint(equalToConstant: 40)
        constaint.isActive = true
        return constaint
    }()
    
    lazy var tabMenu: TabMenu = {
        let tabMenu = TabMenu()
        tabMenu.isScrollEnabled = false
        tabMenu.translatesAutoresizingMaskIntoConstraints = false
        return tabMenu
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(menuData: [Menu] ,indexPath: IndexPath, delegate: CollectionViewUpdate?) {
        self.indexPath = indexPath
        self.delegate = delegate
        self.data = menuData
    }

    func subscribeTo(subject: PageListener, for section: Int) {
        cancellable = subject
            .removeDuplicates()
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pageInfo in
                self?.tabMenu.selectItem(at: IndexPath(row: pageInfo.pageIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(tabMenu)
        tabMenu.edgesToSuperview()
    }
    
    private func updateMenu(){
        tabMenu.performUpdates { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.heightConstraint.constant = self.tabMenu.contentSize.height
                self.delegate?.updateLayout()
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
        cancellable = nil
    }
}

