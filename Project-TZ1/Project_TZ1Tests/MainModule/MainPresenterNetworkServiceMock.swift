//
//  MainPresenterNetworkServiceMock.swift
//  Project_TZ1Tests
//
//  Created by Роман Тищенко on 24.03.2021.
//

import Foundation
import XCTest
@testable import Project_TZ1

final class MainPresenterNetworkServiceMock: NetworkServiceProtocol {
    
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func fetchData<T>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable, T : Encodable {
        let photos = DataMock().createPhotoListMock().compactMap({ $0 as? T })
        completion(.success(photos))
        expectation.fulfill()
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
