//
//  TodoShowAllPresenterTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoShowAllPresenterTests: XCTestCase {

    var sut: TodoShowAllPresenterProtocol!
    var viewMock: TodoShowAllViewMock!
    var routerMock: TodoShowAllRouterMock!
    let todoList = [Todo(testContext: nil)]
    override func setUpWithError() throws {
        viewMock = TodoShowAllViewMock()
        routerMock = TodoShowAllRouterMock()
        sut = TodoShowAllPresenter()
        sut.view = viewMock
        sut.router = routerMock
        sut.todoList = todoList
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_viewDidLoad_sendsTodoList() {
        sut.viewDidLoad()
        XCTAssertTrue(viewMock.receivedTodoList)
    }
    
    func test_router_didCreateDetailsView() {
        let rootView = routerMock.createModule(with: "string", for: todoList)
        sut.router?.createTodoDetailsViewController(from: rootView.self, animated: false, for: todoList.first!)
        
        XCTAssertTrue(rootView.navigationController?.topViewController is TodoDetailsViewController)
    }

}
