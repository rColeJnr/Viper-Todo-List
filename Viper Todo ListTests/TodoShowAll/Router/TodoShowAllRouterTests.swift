//
//  TodoShowAllTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoShowAllRouterTests: XCTestCase {

    var sut: TodoShowAllRouterProtocol!
    let todo = Todo(testContext: nil)
    override func setUpWithError() throws {
        sut = TodoShowAllRouter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_createModule() {
        let view = sut.createModule(with: "Show All", for: [todo])
        let navController = TodoNavigationControllerMock(rootViewController: view)
    
        XCTAssertTrue(navController.topViewController is TodoShowAllViewController)
    }
    
    func test_createDetailsModule() {
        let view = sut.createModule(with: "Show All", for: [todo])
        let navController = TodoNavigationControllerMock(rootViewController: view)
        sut.createTodoDetailsViewController(from: navController.topViewController as! TodoShowAllViewController, animated: false, for: todo)
       
        XCTAssertTrue(view.navigationController?.topViewController is TodoDetailsViewController)
    }

}
