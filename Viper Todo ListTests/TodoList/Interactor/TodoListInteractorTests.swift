//
//  TodoListInteractorTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoListInteractorTests: XCTestCase {

    var sut: TodoListInteractor!
    var presenterMock: TodoListPresenterMock!
    var localManagerMock: TodoListLocalDataManagerMock!
    var remoteManagerMock: TodoListRemoteDataManagerMock!
    override func setUpWithError() throws {
        localManagerMock = TodoListLocalDataManagerMock()
        remoteManagerMock = TodoListRemoteDataManagerMock()
        presenterMock = TodoListPresenterMock()
        sut = TodoListInteractor()
        sut.presenter = presenterMock
        sut.localDataManager = localManagerMock
        sut.remoteDataManager = remoteManagerMock
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        localManagerMock = nil
        remoteManagerMock = nil
    }
    
    func test_localManager_getCompletedTodos() {
        sut.getCompletedTodos()
        
        XCTAssertEqual(localManagerMock.didGetCompletedTodos, true)
        XCTAssertEqual(remoteManagerMock.didFetchTodos, true)
    }
    
    func test_localManager_getInProgressTodos() {
        sut.getInProgressTodos()
        
        XCTAssertEqual(localManagerMock.didGetInProgressTodos, true)
    }
    
    func test_presenter_didGetTodos() {
        let completedTodo = Todo(testContext: nil)
        completedTodo.completed = true
        sut.didGetTodos([Todo(testContext: nil), completedTodo])
        XCTAssertTrue(presenterMock.didDidGetCompletedTodos)
        XCTAssertTrue(presenterMock.didDidGetInProgressTodos)
    }
    
    func test_prsenter_onError() {
        sut.onError(VtlError.InvalidJsonData)
        XCTAssertTrue(presenterMock.didOnError)
    }
    

}
