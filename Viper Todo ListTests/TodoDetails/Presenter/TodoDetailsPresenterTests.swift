//
//  TodoDetailsPresenterTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoDetailsPresenterTests: XCTestCase {
    
    var viewMock: TodoDetailsViewMock!
    var interactorMock: TodoDetailsInteractorMock!
    
    var sut: TodoDetailsPresenter!
    override func setUpWithError() throws {
        viewMock = TodoDetailsViewMock()
        interactorMock = TodoDetailsInteractorMock()
        let todo = Todo(testContext: nil)
        todo.name = "name"
        todo.details = "details"
        todo.completed = false
        sut = TodoDetailsPresenter()
        sut.interactor = interactorMock
        sut.todo = todo
        sut.view = viewMock
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertEqual(viewMock.didShowTodoDetails, true)
    }

    func test_shouldDeleteTodo() {
        sut.deleteTodo(todo: sut.todo!)
        
        sut.didDeleteTodo()
        
        XCTAssertEqual(interactorMock.isTodoDeleted, true)
    }
    
    func test_shouldUpdateTodo() {
        sut.updateTodo(todo: sut.todo!)
        XCTAssertEqual(interactorMock.isTodoUpdated, true)
    }
    
    func test_didDeleteTodo() {
        sut.didDeleteTodo()
        XCTAssertTrue(viewMock.isTodoDeleted)
    }
    
    func test_didUpdateTodo() {
        sut.didUpdateTodo()
        XCTAssertTrue(viewMock.isTodoUpdated)
    }

}
