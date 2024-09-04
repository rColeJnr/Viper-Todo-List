//
//  TodoListPresenterTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoListPresenterTests: XCTestCase {

    var sut: TodoListPresenterProtocol & TodoListInteractorResponseProtocol = TodoListPresenter()
    var interactorMock: TodoListInteractorMock!
    var routerMock: TodoListRouterMock!
    var viewMock: TodoListViewMock!
    override func setUpWithError() throws {
        viewMock = TodoListViewMock()
        interactorMock = TodoListInteractorMock()
        routerMock = TodoListRouterMock()
        sut = TodoListPresenter()
        sut.interactor = interactorMock
        sut.router = routerMock
        sut.view = viewMock
    }

    override func tearDownWithError() throws {
//        sut = nil
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, true)
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, true)
    }
    
    func test_router() {
        let view = sut.router?.createModule()
        
        XCTAssertTrue(view?.topViewController is TodoListViewController)
    }

    func test_router_createTodoDetailsModule() {
        let view = routerMock.createModule()
        sut.showTodoDetails(from: view.topViewController.self as! TodoListViewController, for: Todo(testContext: nil))

        XCTAssertTrue(view.topViewController is TodoDetailsViewController)
    }

    func test_router_createTodoCreateModule() {
        let view = routerMock.createModule()
        sut.createTodoCreateModule(from: view.topViewController as! TodoListViewProtocol)

        XCTAssertTrue(view.topViewController is TodoCreateViewController)
    }
    
    func test_router_createTodoShowAllModule() {
        sut.getInProgressTodos()
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
    }
    
    func test_view_didGetCompletedTodos() {
        sut.didGetCompletedTodos([Todo(testContext: nil)])
        XCTAssertEqual(viewMock.isShowCompletedTodos, true)
        XCTAssertEqual(viewMock.isHideCompletedTodosLoading, true)
    }
    
    func test_view_didGetInProgressTodos() {
        sut.didGeInProgressTodos([Todo(testContext: nil)])
        XCTAssertEqual(viewMock.ishideInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowInProgressTodos, true)
    }
    
    func test_view_onError() {
        sut.onError(VtlError.CouldNotSaveObject)
        XCTAssertEqual(viewMock.ishideInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isHideCompletedTodosLoading, true)
        XCTAssertEqual(viewMock.isShowError, true)
    }

}
