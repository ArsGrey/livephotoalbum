//
//  DetailViewProtocolMock.swift
//  Project_TZ1Tests
//
//  Created by Arslan Simba on 25.03.2021.
//

import Foundation
import XCTest
@testable import Project_TZ1

final class DetailViewProtocolMock: DetailViewProtocol {
    
    private let callRecoder: CallRecorder
    
    init(callRecoder: CallRecorder) {
        self.callRecoder = callRecoder
    }
    
    func showMedia() {
        callRecoder.recordCall(callType: .detailViewShowMedia)
    }
    
    func failure(error: Error) {
        
    }
}
