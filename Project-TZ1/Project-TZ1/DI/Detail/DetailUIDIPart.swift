//
//  DetailUIDIPart.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 12.03.2021.
//

import Foundation
import DITranquillity

final class DetailUIDIPart: DIPart {
    static func load(container: DIContainer) {
        container.registerStoryboard(name: "DetailViewController")
            .as(check: UIStoryboard.self, tag: DetailViewController.self) {$0}
        
        container.register(DetailViewController.self)
            .as(check: DetailViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
    }
}
