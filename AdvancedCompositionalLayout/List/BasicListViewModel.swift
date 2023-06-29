//
//  BasicListViewModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 28.06.2023.
//

import Foundation
import Combine

typealias LoadStatusListener = PassthroughSubject<Bool, Never>

class BasicListViewModel {
    
    var nextData: String?
    @Published var isLoading: Bool = false
    @Published var personList: [Person] = []
    var isSuccessfullyLoaded = LoadStatusListener()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard !isLoading else {return}
        isLoading = true
        PersonDatasource.fetch(next: nextData) { [weak self] response, error in
            guard error == nil else {
                self?.isLoading = false
                self?.handleError(with: error)
                return
            }

            self?.handleResponse(response)
        }
    }
    
    func handleResponse(_ response: FetchResponse?) {
        isLoading = false
        isSuccessfullyLoaded.send(true)
        nextData = response?.next
        
        if personList.count == 0 && (response?.person ?? []).count == 0{
            handleError(with: nil)
        }
        else {
            personList.append(contentsOf: response?.person ?? [])
        }
        
    }
    
    func handleError(with error: FetchError?) {
        isSuccessfullyLoaded.send(false)
        NotificationCenter.default.post(name: Notification.Name("didFailToReceiveDataWithError"), object: nil)
    }
}
