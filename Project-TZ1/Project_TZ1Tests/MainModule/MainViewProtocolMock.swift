//
//  MainViewProtocolMock.swift
//  Project_TZ1Tests
//
//  Created by Роман Тищенко on 24.03.2021.
//

import Foundation
import XCTest
@testable import Project_TZ1

final class MainViewProtocolMock: MainViewProtocol {
    
    private let callRecorder: CallRecorder
    
    init(callRecorder: CallRecorder) {
        self.callRecorder = callRecorder
    }
    
    func showCollection(data: MainViewModel) {
        callRecorder.recordCall(callType: .mainViewShowPhotos)
    }
    
    func showError(error: Error) {
        
    }
    
    
}
