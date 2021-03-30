//
//  DetailPresenterNetworkServiceMock.swift
//  Project_TZ1Tests
//
//  Created by Arslan Simba on 25.03.2021.
//

import Foundation
import XCTest
@testable import Project_TZ1

final class DetailPresenterNetworkServiceMock: NetworkServiceProtocol {
    
    func fetchData<T>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable, T : Encodable {
        let photos = DataMock().createPhotoListMock().compactMap({ $0 as? T })
        completion(.success(photos))
    }
    
    func fetchData<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        let photos = DataMock().createPhotoListMock().compactMap({ $0 as? T })
        completion(.success(photos[0]))
    }
    
    func downloadData(url: URL, group: DispatchGroup, completion: @escaping (Result<URL, Error>) -> Void) {
        let url = DataMock().createUrlMock()
        completion(.success(url))
    }
    
    func fetchData(url: URL, group: DispatchGroup, comppletion: @escaping (Result<Data, Error>) -> Void) {
        let data = DataMock().createDataMock()
        comppletion(.success(data))
    }
}
