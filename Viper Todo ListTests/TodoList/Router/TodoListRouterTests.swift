//
//  TodoListRouterTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoListRouterTests: XCTestCase {

    var sut: TodoListRouter!
    var navControllerMock: TodoNavigationControllerMock!
    override func setUpWithError() throws {
        sut = TodoListRouter()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_createModule() {
        let view = sut.createModule()
       
        XCTAssertTrue(view.topViewController is TodoListViewController)
    }
    
    func test_createTodoCreateModule() {
        let view = sut.createModule()
      
        sut.createTodoCreateModule(from: view.topViewController as! TodoListViewProtocol, animated: false)
        
        XCTAssertTrue(view.viewControllers.last is TodoCreateViewController)
    }

    func test_createDetailsModule() {
        let view = sut.createModule()
        
        sut.createTodoDetailsViewController(from: view.topViewController as! TodoListViewProtocol, animated: false, for: Todo(testContext: nil))
        
        XCTAssertTrue(view.viewControllers.last is TodoDetailsViewController)
    }

    func test_createShowAllModule() {
        let view = sut.createModule()
        
        sut.createTodoShowAllViewController(from: view.topViewController as! TodoListViewProtocol, animated: false, with: "Show all", for: [Todo(testContext: nil)])
        
        XCTAssertTrue(view.viewControllers.last is TodoShowAllViewController)
    }

}
