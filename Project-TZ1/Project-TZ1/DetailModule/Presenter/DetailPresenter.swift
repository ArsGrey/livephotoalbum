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
    var photo: Photos?
    var filePhotoUrl: URL?
    var fileMovieUrl: URL?
    private let dispatchGroup = DispatchGroup()
    
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
                self?.saveData(url: url, fileType: .photo(UUID()))
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
                self?.saveData(url: url, fileType: .movie(UUID()))
            case .failure(let error):
                self?.view?.failure(error: error)
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func saveData(url: URL, fileType: FileType) {
        guard let cache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        do {
            let file = cache.appendingPathComponent(fileType.rawValue)
            try FileManager.default.moveItem(at: url, to: file)
            switch fileType {
            case .photo:
                self.filePhotoUrl = file
            case .movie:
                self.fileMovieUrl = file
            }
            dispatchGroup.leave()
        } catch {
            print(error.localizedDescription)
        }
    }
}

