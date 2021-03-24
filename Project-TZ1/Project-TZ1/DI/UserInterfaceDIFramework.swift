//
//  UserInterfaceDIFramework.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 13.03.2021.
//

import Foundation
import DITranquillity

final class UserInterfaceDIFramework: DIFramework {
    static func load(container: DIContainer) {
        container.append(part: MainUIDIPart.self)
        container.append(part: DetailUIDIPart.self)
    }
}
