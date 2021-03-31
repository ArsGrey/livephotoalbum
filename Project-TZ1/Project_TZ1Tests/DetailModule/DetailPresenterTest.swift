//
//  DetailPresenterTest.swift
//  Project_TZ1Tests
//
//  Created by Arslan Simba on 25.03.2021.
//

import XCTest
import DITranquillity
@testable import Project_TZ1

class DetailPresenterTest: XCTestCase {
    
    private let container: DIContainer = {
        let container = DIContainer()
        
        container.register(CallRecorder.init)
            .lifetime(.perContainer(.weak))
        
        container.register(DispatchGroup.init)
            .lifetime(.perContainer(.weak))
        
        container.register(DetailViewProtocolMock.init)
            .as(check: DetailViewProtocol.self) {$0}
            .lifetime(.perContainer(.strong))
        
        container.register(DetailPresenterNetworkServiceMock.init)
            .as(check: NetworkServiceProtocol.self) {$0}
            .lifetime(.perContainer(.weak))
        
        container.register(FileServiceMock.init)
            .as(check: FileServiceProtocol.self) {$0}
            .lifetime(.perContainer(.weak))
        
        container.register(DetailPresenter.init)
            .as(check: DetailPresenterProtocol.self) {$0}
            .injection(cycle: true, \.view)
            .lifetime(.objectGraph)
        
        assert(container.makeGraph().checkIsValid(checkGraphCycles: true))
        
        return container
    }()
    
    func testPhotoUrlShowed() {
        let presenter: DetailPresenter = container.resolve()
        let dispatchGroup: DispatchGroup = container.resolve()
        let expectation = self.expectation(description: "testPhotoUrl")
        
        presenter.photo = DataMock().createPhotoMock()
        presenter.fetchMedia()
        
        dispatchGroup.notify(queue: .main) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse((presenter.filePhotoUrl == nil))
    }
    
    func testMovieUrlShowed() {
        let presenter: DetailPresenter = container.resolve()
        let dispatchGroup: DispatchGroup = container.resolve()
        let expectation = self.expectation(description: "testMovieUrl")
        
        presenter.photo = DataMock().createPhotoMock()
        presenter.fetchMedia()
        
        dispatchGroup.notify(queue: .main) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse((presenter.fileMovieUrl == nil))
    }
    
    func testFetchMedia() {
        let presenter: DetailPresenter = container.resolve()
        let dispatchGroup: DispatchGroup = container.resolve()
        let callRecoder: CallRecorder = container.resolve()
        let expectation = self.expectation(description: "showMedia")
        
        presenter.photo = DataMock().createPhotoMock()
        presenter.fetchMedia()
        
        dispatchGroup.notify(queue: .main) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(callRecoder.isCallRecorded(callType: .detailViewShowMedia))
    }
}
