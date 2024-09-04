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
    var vcMock: TodoDetailsViewControllerMock!
    var sut: TodoDetailsView!
    override func setUpWithError() throws {
        todo.name = "Ricardo"
        todo.details = "Ricardo is an android developer"
        todo.completed = true
        formatter.dateFormat = "dd'-'MM'-'yyyy"
        todo.dateCreated = formatter.date(from: "26-08-2024")!
        todo.dateCompleted = formatter.date(from: "06-09-2024")!
        vcMock = TodoDetailsViewControllerMock()
        sut = TodoDetailsView()
        sut.delegate = vcMock.self
        sut.configure(with: todo)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_todoIsConfigured() {
        XCTAssertNotNil(todo)
    }

    func test_viewIsConfiguredWithTodo() {
        let todo = sut.isViewConfigured()
        XCTAssertEqual(todo.name, "Ricardo")
        XCTAssertEqual(todo.details, "Ricardo is an android developer")
        XCTAssertNotEqual(todo.completed, false)
        XCTAssertEqual(todo.dateCreated, formatter.date(from: "26-08-2024")!)
        XCTAssertEqual(todo.dateCompleted, formatter.date(from: "06-09-2024")!)
    }
    
    func test_shouldNotUpdateTodo() {
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertFalse(shouldUpdate)
    }
    
    func test_shouldUpdateTodoName() {
        todo.name = "Antonio"
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoDetails() {
        todo.details = "DETAILS"
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoMarkCompleted() {
        todo.completed = !todo.completed
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldUpdateTodoDateCompleted() {
        sut.markAsComplete.sendActions(for: .touchUpInside)
        let shouldUpdate = sut.shouldUpdateTodo()
        
        XCTAssertTrue(shouldUpdate)
    }
    
    func test_shouldNotShowErrorView() {
        todo.name = "New name"
        sut.saveBtn.sendActions(for: .touchUpInside)
            
        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func test_shouldShowErrorView() {
        sut.saveBtn.sendActions(for: .touchUpInside)
        
        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    func test_shouldUpdateMarkAsCompleted() {
        XCTAssertEqual(sut.markAsComplete.configuration?.title, "Mark as In Progress")
        sut.markAsComplete.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.markAsComplete.configuration?.title, "Mark as Completed")
        sut.markAsComplete.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.markAsComplete.configuration?.title, "Mark as In Progress")
    }
    
    func test_deleteBtnDeletesTodo() {
        sut.deleteBtn.sendActions(for: .touchUpInside)
   
        XCTAssertTrue(vcMock.didDeleteTodo)
    }
    
    func test_saveBtnUpdatesTodo() {
        todo.name = "Different name"
        sut.saveBtn.sendActions(for: .touchUpInside)
   
        XCTAssertTrue(vcMock.didUpdateTodo)
    }
}
