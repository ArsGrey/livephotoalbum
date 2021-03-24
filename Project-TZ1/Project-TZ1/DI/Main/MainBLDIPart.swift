//
//  MainBLDIPart.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 12.03.2021.
//

import Foundation
import DITranquillity

final class MainBLDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register(DispatchGroup.init)
            .lifetime(.objectGraph)
        
        container.register(MainPresenter.init)
            .as(check: MainPresenterProtocol.self) {$0}
            .injection(cycle: true, \.view)
            .lifetime(.objectGraph)
    }
}
