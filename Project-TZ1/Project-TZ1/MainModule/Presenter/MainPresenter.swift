//
//  MainPresenter.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func showCollection(data: [Data])
    func showError(error: Error)
}

protocol MainViewPresenterProtocol: class {
    func getPhotos()
    var photos: [Photos] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var photos: [Photos] = []
    private let dispatchGroup = DispatchGroup()
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol ) {
        self.view = view
        self.networkService = networkService
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
        for photo in photos {
            guard let url = URL(string: photo.small_url) else { continue }
            networkService.fetchData(url: url, group: dispatchGroup) {
                switch $0 {
                case .failure:
                    return
                case .success(let data):
                    dataList.append(data)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.showCollection(data: dataList)
        }
    }
}
