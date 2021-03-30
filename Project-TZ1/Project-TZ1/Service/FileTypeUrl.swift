//
//  ServiceHelper.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 30.03.2021.
//

import Foundation

protocol FileTypeUrlProtocol {
    func fetchFileTypeUrl(url: URL, fileType: FileType) -> URL?
}

final class FileTypeUrl: FileTypeUrlProtocol {

    func fetchFileTypeUrl(url: URL, fileType: FileType) -> URL? {
        guard let cache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        do {
            let file = cache.appendingPathComponent(fileType.rawValue)
            try FileManager.default.moveItem(at: url, to: file)
            switch fileType {
            case .photo:
                return file
            case .movie:
                return file
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
