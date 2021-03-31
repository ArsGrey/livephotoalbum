//
//  DetailPresenter.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 01.02.2021.
//

import Foundation
import UIKit

protocol DetailViewProtocol: class {
    func showMedia()
    func failure(error: Error)
}

protocol DetailPresenterProtocol: class {
    func fetchMedia()
    var filePhotoUrl: URL? { get set }
    var fileMovieUrl: URL? { get set }
    var photo: Photos? { get set }
}

enum FileType {
    case photo(UUID)
    case movie(UUID)
    
    var rawValue: String {
        switch self {
        case .movie(let uuid):
            return "\(uuid.uuidString).mov"
        case .photo(let uuid):
            return "\(uuid.uuidString).jpg"
        }
    }
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    private let networkService: NetworkServiceProtocol
    let fileTypeUrl: FileServiceProtocol
    var photo: Photos?
    var filePhotoUrl: URL?
    var fileMovieUrl: URL?
    private let dispatchGroup: DispatchGroup
    
    init(networkService: NetworkServiceProtocol, dispatchGroup: DispatchGroup, fileTypeUrl: FileServiceProtocol) {
        self.networkService = networkService
        self.dispatchGroup = dispatchGroup
        self.fileTypeUrl = fileTypeUrl
    }
    
    func fetchMedia() {
        self.fetchPhoto()
        self.fetchMovie()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            guard self.filePhotoUrl != nil,
                  self.fileMovieUrl != nil else { return }
            self.view?.showMedia()
        }
    }
    
    private func fetchPhoto() {
        guard let url = URL(string: photo?.large_url ?? "") else { return }
        dispatchGroup.enter()
        networkService.downloadData(url: url, group: dispatchGroup) { [weak self] result in
            switch result {
            case .success(let url):
                self?.filePhotoUrl = self?.fileTypeUrl.saveFile(by: url, with: .photo(UUID()))
                self?.dispatchGroup.leave()
            case.failure(let error):
                self?.view?.failure(error: error)
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func fetchMovie() {
        guard let url = URL(string: photo?.movie_url ?? "") else { return }
        dispatchGroup.enter()
        networkService.downloadData(url: url, group: dispatchGroup) { [weak self] result in
            switch result {
            case .success(let url):
                self?.fileMovieUrl = self?.fileTypeUrl.saveFile(by: url, with: .movie(UUID()))
                self?.dispatchGroup.leave()
            case .failure(let error):
                self?.view?.failure(error: error)
                self?.dispatchGroup.leave()
            }
        }
    }
}

