//
//  DataMock.swift
//  Project_TZ1Tests
//
//  Created by Роман Тищенко on 24.03.2021.
//

import Foundation
@testable import Project_TZ1

struct DataMock {
    
    func createUrlMock() -> URL {
        decode(jsonName: "data", type: [Photos].self).map({ URL(string: $0.small_url)! })[0]
    }
    
    func createUrlListMock() -> [URL] {
        decode(jsonName: "data", type: [Photos].self).map({ URL(string: $0.small_url)! })
    }
    
    func createPhotoListMock() -> [Photos] {
        decode(jsonName: "data", type: [Photos].self)
    }
    
    func createPhotoMock() -> Photos {
        decode(jsonName: "data", type: [Photos].self)[0]
    }
    
    func createDataListMock() -> [Data] {
        decode(jsonName: "data", type: [Photos].self).map({ Data(base64Encoded: $0.small_url)! })
    }
    
    func createDataMock() -> Data {
        decode(jsonName: "data", type: [Photos].self).map({ _ in Data() })[0]
    }
    
    private func decode<T: Decodable>(jsonName: String, type: T.Type, decoder: JSONDecoder = .init()) -> T {
        let jsonPath = Bundle(for: Project_TZ1Tests.self).path(forResource: jsonName, ofType: "json")!
        let jsonString = try! String.init(contentsOfFile: jsonPath)
        let data = jsonString.data(using: .utf8)
        return try! decoder.decode(type, from: data!)
    }
}
