//
//  MainPresenter.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    func getPhotos()
    var photos: [Photos]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var photos: [Photos]?
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol ) {
        self.view = view
        self.networkService = networkService
        getPhotos()
    }
    
    func getPhotos() {
        guard let url = URL(string: API.modelUrl) else { return }
        networkService.fetchData(url: url) { [weak self] (result: Result<[Photos], Error>) in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                    self?.view?.succes()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
