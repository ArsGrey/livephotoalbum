//
//  DetailBLDIPart.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 12.03.2021.
//

import Foundation
import DITranquillity

final class DetailBLDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(DetailPresenter.init)
            .as(check: DetailPresenterProtocol.self) {$0}
            .injection(cycle: true, \.view)
            .lifetime(.objectGraph)
    }
}
