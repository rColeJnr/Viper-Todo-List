//
//  TodoCreatePresenterTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoCreatePresenterTests: XCTestCase {

    var sut: TodoCreatePresenter!
    var viewMock: TodoCreateViewMock!
    var interactorMock: TodoCreateInteractorMock!
    var todo: TodoModel!
    override func setUpWithError() throws {
        sut = TodoCreatePresenter()
        interactorMock = TodoCreateInteractorMock()
        viewMock = TodoCreateViewMock()
        sut.interactor = interactorMock
        sut.view = viewMock
        todo = TodoModel(name: "Name", details: "Details", completed: true, dateCreated: Date.now)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_createTodo() {
        sut.createTodo(todo: todo)
        XCTAssertEqual(interactorMock.didCreateTodo, true)
    }
    
    func test_didCreateTodo() {
        sut.didCreateTodo()
        XCTAssertEqual(viewMock.isTodoCreated, true)
    }
    
}
