//
//  PaginationListViewController.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation
import UIKit
import Combine

protocol PaginationListDelegate: AnyObject {
    func getViewModel() -> PaginationListViewModel
    func pagination()
}

class PaginationListViewController: UIViewController {
    
    lazy var collectionView = PaginationList()
    
    private lazy var viewModel = PaginationListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pagination List"
        configureCollectionView()
        configureBindings()
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        collectionView.listDelegate = self
    }
    
    private func configureBindings() {
        viewModel.$personList
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] personList in
                self?.collectionView.performUpdates()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if self.viewModel.personList.isEmpty && isLoading {
                    self.collectionView.setLoading()
                }
                else {
                    self.collectionView.refreshControl?.endRefreshing()
                    self.collectionView.clear()
                }
            }
            .store(in: &cancellables)
        
        viewModel.isSuccessfullyLoaded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSuccess in
                guard let self = self else {return}
                
                if self.viewModel.personList.isEmpty && !isSuccess {
                    let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.tryReload))
                    self.collectionView.setErrorMessage(nil, recognizer: recognizer)
                }

            }
            .store(in: &cancellables)
    }
    
    @objc func tryReload(){
        guard !viewModel.isLoading else {return}
        collectionView.clear()
        viewModel.loadData()
    }
}

extension PaginationListViewController: PaginationListDelegate {
    func getViewModel() -> PaginationListViewModel {
        return viewModel
    }

    func pagination() {
        guard viewModel.nextData != nil else { return }
        viewModel.loadData()
    }

}
