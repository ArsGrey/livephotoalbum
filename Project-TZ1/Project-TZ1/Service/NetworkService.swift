//
//  NetworkService.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void)
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func downloadData(url: URL, group: DispatchGroup, completion: @escaping (Result<URL, Error>) -> Void)
    func fetchData(url: URL, group: DispatchGroup, comppletion: @escaping (Result<Data, Error>) -> Void)
}

enum NetworkError: Error {
    case failedDecoding
    case emptyData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedDecoding:
            return "Failed decoding, check response"
        case .emptyData:
            return "Response data is empty"
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    
    private let session = URLSession.shared
    private let backgroundQueue = DispatchQueue(label: "networking", qos: .background)
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        backgroundQueue.async { [weak self] in
            self?.session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                
                guard let result = try? JSONDecoder().decode([T].self, from: data) else {
                    completion(.failure(NetworkError.failedDecoding))
                    return
                }
                
                completion(.success(result))
            }
            .resume()
        }
    }
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        backgroundQueue.async { [weak self] in
            self?.session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(NetworkError.failedDecoding))
                    return
                }
                
                completion(.success(result))
            }
            .resume()
        }
    }
    
    func downloadData(url: URL, group: DispatchGroup, completion: @escaping (Result<URL, Error>) -> Void) {
        backgroundQueue.async(group: group) { [weak self] in
            self?.session.downloadTask(with: url, completionHandler: { (url, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                guard let url = url else {
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                completion(.success(url))
            }).resume()
        }
    }
    
    func fetchData(url: URL, group: DispatchGroup, comppletion: @escaping (Result<Data, Error>) -> Void) {
        backgroundQueue.async(group: group) { [weak self] in
            group.enter()
            self?.session.dataTask(with: url) { data, _, error in
                if let error = error {
                    comppletion(.failure(error))
                    group.leave()
                }
                guard let data = data else {
                    comppletion(.failure(NetworkError.emptyData))
                    group.leave()
                    return
                }
                comppletion(.success(data))
                group.leave()
            }.resume()
        }
    }
}
