//
//  TodoCreateInteractorTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoCreateInteractorTests: XCTestCase {

    var interactor: TodoCreateInteractor!
    var presenterMock: TodoCreateInteratorResponseMock!
    var dataManagerMock: TodoCreateDataManagerMock!
    var todo: TodoModel!
    override func setUpWithError() throws {
        todo = TodoModel(name: "Name", details: "Details", completed: true, dateCreated: Date.now)
        presenterMock = TodoCreateInteratorResponseMock()
        dataManagerMock = TodoCreateDataManagerMock()
        interactor = TodoCreateInteractor()
        interactor.presenter = presenterMock
        interactor.dataManager = dataManagerMock
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func test_createTodo() {
        interactor.createTodo(todo: todo)
        XCTAssertTrue(dataManagerMock.didCreateTodo)
    }
    
    func test_didCreateTodo() {
        interactor.presenter?.didCreateTodo()
        XCTAssertEqual(presenterMock.isTodoCreated, true)
    }
    
}
