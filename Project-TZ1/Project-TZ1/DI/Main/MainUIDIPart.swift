//
//  MainUIDIPart.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 12.03.2021.
//

import Foundation
import DITranquillity

final class MainUIDIPart: DIPart {
    static func load(container: DIContainer) {
        container.registerStoryboard(name: "MainViewController")
            .as(check: UIStoryboard.self, tag: MainViewController.self) {$0}
        
        container.register(MainViewController.self)
            .as(check: MainViewProtocol.self) {$0}
            .injection(cycle: true, \.presenter)
            .injection(\.presenter)
            .lifetime(.objectGraph)
    }
}
