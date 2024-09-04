//
//  TodoDetailsInteractorTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoDetailsInteractorTests: XCTestCase {

    var sut: TodoDetailsInteractor!
    var dataManager: TodoDetailsLocalDataManagerMock!
    var presenter: TodoDetailsInteractorResponseMock!
    let todo = Todo(testContext: nil)
  
    override func setUpWithError() throws {
        dataManager = TodoDetailsLocalDataManagerMock()
        presenter = TodoDetailsInteractorResponseMock()
        sut = TodoDetailsInteractor()
        sut.dataManager = dataManager
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_deleteTodo() {
        sut.deleteTodo(todo: todo)
        XCTAssertTrue(dataManager.didDeleteTodo)
    }
    
    func test_updateTodo() {
        sut.updateTodo(todo: todo)
        XCTAssertTrue(dataManager.didUpdateTodo)
    }
    
    func test_didDeleteTodo() {
        sut.presenter?.didDeleteTodo()
        XCTAssertTrue(presenter.isTodoDeleted)
    }
    
    func test_didUpdateTodo() {
        sut.presenter?.didUpdateTodo()
        XCTAssertTrue(presenter.isTodoUpdated)
    }
}
