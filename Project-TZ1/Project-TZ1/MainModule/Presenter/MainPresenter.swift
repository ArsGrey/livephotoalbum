//
//  MainPresenter.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func showCollection(data: MainViewModel)
    func showError(error: Error)
}

protocol MainPresenterProtocol: class {
    func getPhotos()
    var photos: [Photos] { get set }
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    var photos: [Photos] = []
    private let dispatchGroup: DispatchGroup
    
    init(networkService: NetworkServiceProtocol, dispatchGroup: DispatchGroup) {
        self.networkService = networkService
        self.dispatchGroup = dispatchGroup
    }
    
    func getPhotos() {
        guard let url = URL(string: API.modelUrl) else { return }
        networkService.fetchData(url: url) { [weak self] (result: Result<[Photos], Error>) in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.fetchData()
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(error: error)
                }
            }
        }
    }
    
    private func fetchData() {
        var dataList = [Data]()
        photos.forEach {
            guard let url = URL(string: $0.small_url) else { return }
            networkService.fetchData(url: url, group: dispatchGroup) {
                switch $0 {
                case .failure: return
                case .success(let data):
                    dataList.append(data)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.showCollection(data: MainViewModel(data: dataList))
        }
    }
}
