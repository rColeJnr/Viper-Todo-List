//
//  TodoDetailsInteractorTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoDetailsViewTests: XCTestCase {
    
    let todo = Todo(testContext: nil)
    let formatter = DateFormatter()
    var sut: TodoDetailsView!
    override func setUpWithError() throws {
        todo.name = "Ricardo"
        todo.details = "Ricardo is an android developer"
        todo.completed = true
        formatter.dateFormat = "dd'-'MM'-'yyyy"
        todo.dateCreated = formatter.date(from: "26-08-2024")!
        todo.dateCompleted = formatter.date(from: "06-09-2024")!
        sut = TodoDetailsView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_todoIsConfigured() {
        XCTAssertNotNil(todo)
    }

    func test_viewIsConfiguredWithTodo() {
        sut.configure(with: todo)
        let todo = sut.isViewConfigured()
        XCTAssertEqual(todo.name, "Ricardo")
        XCTAssertEqual(todo.details, "Ricardo is an android developer")
        XCTAssertNotEqual(todo.completed, false)
        XCTAssertEqual(todo.dateCreated, formatter.date(from: "26-08-2024")!)
        XCTAssertEqual(todo.dateCompleted, formatter.date(from: "06-09-2024")!)
    }
    
    func test_shouldNotUpdateTodo() {
        sut.configure(with: todo)
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertFalse(shouldUpdate)
    }
    
    func test_shouldUpdateTodoName() {
        sut.configure(with: todo)
        todo.name = "Antonio"
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoDetails() {
        sut.configure(with: todo)
        todo.details = "DETAILS"
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoMarkCompleted() {
        sut.configure(with: todo)
        todo.completed = !todo.completed
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoDateCompleted() {
        sut.configure(with: todo)
        sut.markAsComplete.sendActions(for: .touchUpInside)
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldNotShowErrorView() {
        sut.configure(with: todo)
        todo.name = "New name"
        sut.saveBtn.sendActions(for: .touchUpInside)
            
        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func test_shouldShowErrorView() {
        sut.configure(with: todo)
        sut.saveBtn.sendActions(for: .touchUpInside)
        
        XCTAssertFalse(sut.errorView.isHidden)
    }
}
