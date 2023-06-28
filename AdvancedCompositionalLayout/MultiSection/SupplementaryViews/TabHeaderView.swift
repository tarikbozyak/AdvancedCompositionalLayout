//
//  TabHeaderView.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import UIKit
import Combine

protocol GrandTaskDelegate: AnyObject {
    func scrollToSelectedMenu(indexPath: IndexPath)
}

class TabHeaderView: UICollectionReusableView {
    
    var cancellable: AnyCancellable?
    weak var delegate: MenuTabProtocol?
    var indexPath: IndexPath!
    
    var data: [Menu] = [] {
        didSet {
            guard oldValue.isEmpty else {return}
            tabMenu.data = data
            updateMenu()
        }
    }
    
    private lazy var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        return blurVisualEffectView
    }()
    
    lazy var heightConstraint: NSLayoutConstraint = {
        let constaint = tabMenu.heightAnchor.constraint(equalToConstant: 40)
        constaint.isActive = true
        return constaint
    }()
    
    lazy var tabMenu: TabMenu = {
        let tabMenu = TabMenu()
        tabMenu.grandTaskDelegate = self
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

    func configure(menuData: [Menu] ,indexPath: IndexPath, delegate: MenuTabProtocol?) {
        self.indexPath = indexPath
        self.delegate = delegate
        self.data = menuData
    }

    func subscribeTo(subject: PageListener, for section: Int) {
        cancellable = subject
            .removeDuplicates()
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .sink { [weak self] pageInfo in
                self?.tabMenu.selectItem(at: IndexPath(row: pageInfo.pageIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(tabMenu)
        backgroundView.edgesToSuperview()
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

extension TabHeaderView: GrandTaskDelegate {
    func scrollToSelectedMenu(indexPath: IndexPath) {
        delegate?.scrollGrandCell(for: IndexPath(row: indexPath.row, section: self.indexPath.section))
    }
}

