//
//  ApplicationDI.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 12.03.2021.
//

import Foundation
import DITranquillity

final class ApplicationDI: DIFramework {
    static func load(container: DIContainer) {
        container.register(NetworkService.init)
            .as(check: NetworkServiceProtocol.self) {$0}
            .lifetime(.perContainer(.weak))
    }
    
    static let container: DIContainer = {
        let container = DIContainer()
        container.append(framework: ApplicationDI.self)
        container.append(framework: BusinessLogicDIFramework.self)
        container.append(framework: UserInterfaceDIFramework.self)
        
        if !container.makeGraph().checkIsValid(checkGraphCycles: true) {
            fatalError("DI graph is not valid!")
        }
        return container
    }()
}
