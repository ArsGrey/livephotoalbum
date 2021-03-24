//
//  BusinessLogicDIFrameWork.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 13.03.2021.
//

import Foundation
import DITranquillity

final class BusinessLogicDIFramework: DIFramework {
    static func load(container: DIContainer) {
        container.append(part: MainBLDIPart.self)
        container.append(part: DetailBLDIPart.self)
    }
}
