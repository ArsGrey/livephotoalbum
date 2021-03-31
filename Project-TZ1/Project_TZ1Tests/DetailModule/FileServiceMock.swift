//
//  FileTypeUrlMock.swift
//  Project_TZ1Tests
//
//  Created by Arslan Simba on 30.03.2021.
//

import Foundation
import XCTest
@testable import Project_TZ1

final class FileServiceMock: FileServiceProtocol {
    func saveFile(by: URL, with: FileType) -> URL? {
        DataMock().createUrlMock()
    }
}
