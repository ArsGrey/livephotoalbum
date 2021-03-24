//
//  MainPresenterTest.swift
//  Project_TZ1Tests
//
//  Created by Роман Тищенко on 24.03.2021.
//

import XCTest
import DITranquillity
@testable import Project_TZ1

class MainPresenterTest: XCTestCase {
    
    private let container: DIContainer = {
        let container = DIContainer()
        
        container.register(CallRecorder.init)
            .lifetime(.perContainer(.weak))
        
        container.register { XCTestExpectation.init(description: "networkPhotoList") }
            .lifetime(.perContainer(.weak))
        
        container.register(DispatchGroup.init)
            .lifetime(.perContainer(.weak))
        
        container.register(MainViewProtocolMock.init)
            .as(check: MainViewProtocol.self) {$0}
            .lifetime(.perContainer(.strong))
        
        container.register(MainPresenterNetworkServiceMock.init)
            .as(check: NetworkServiceProtocol.self) {$0}
            .lifetime(.perContainer(.weak))
        
        container.register { MainPresenter.init(networkService: $0, dispatchGroup: $1) }
            .as(check: MainPresenterProtocol.self) {$0}
            .injection(cycle: true, \.view)
            .lifetime(.objectGraph)
        
        assert(container.makeGraph().checkIsValid(checkGraphCycles: true))
        
        return container
    }()

    func testPhotosIsNotEmpty() {
        let presenter: MainPresenter = container.resolve()
        let expectaion: XCTestExpectation = container.resolve()
        
        presenter.getPhotos()
        
        wait(for: [expectaion], timeout: 2)
        XCTAssertTrue(presenter.photos.isEmpty == false)
    }
    
    func testPhotosDataShowed() {
        let presenter: MainPresenterProtocol = container.resolve()
        let dispatchGroup: DispatchGroup = container.resolve()
        let callRecorder: CallRecorder = container.resolve()
        let expectaion = self.expectation(description: "showPhotos")
        
        presenter.getPhotos()
        
        dispatchGroup.notify(queue: .main) {
            expectaion.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(callRecorder.isCallRecorded(callType: .mainViewShowPhotos))
    }
}
