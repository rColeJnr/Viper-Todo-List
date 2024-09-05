//
//  TodoListIViewTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 05/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoListIViewTests: XCTestCase {
    
    
    var sut: TodoListViewController!
    var presenterMock: TodoListPresenterMock!
    var interactorMock: TodoListInteractorMock!
    var viewMock: TodoListViewMock!
    let todoList = [Todo(testContext: nil)]
    override func setUpWithError() throws {
        presenterMock = TodoListPresenterMock()
        interactorMock = presenterMock.interactor as? TodoListInteractorMock
        viewMock = presenterMock.view as? TodoListViewMock
        sut = TodoListViewController()
        sut.presenter = presenterMock
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }

    func test_presenter_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, true)
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, true)
        XCTAssertEqual(viewMock.isShowError, false )
        
    }
    
    func test_presenter_getInProgressTodos(){
        sut.presenter?.getInProgressTodos()
        
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, false)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, false)
        XCTAssertEqual(viewMock.isShowError, false )
    }
    
    func test_presenter_createTodoCreateModule() {
        let rootView = presenterMock.router?.createModule()
     
        sut.presenter?.createTodoCreateModule(from: rootView?.topViewController as! TodoListViewController)
    
        XCTAssertTrue(rootView?.topViewController is TodoCreateViewController)
    }
    
    func test_presenter_createTodoDetailsModule() {
        let rootView = presenterMock.router?.createModule()
     
        sut.presenter?.showTodoDetails(from: rootView?.topViewController as! TodoListViewController, for: Todo(testContext: nil))

        XCTAssertTrue(rootView?.topViewController is TodoDetailsViewController)
    }
    
    func test_presenter_createTodoShowAllModule() {
        let rootView = presenterMock.router?.createModule()
     
        presenterMock.router?.createTodoShowAllViewController(from: rootView?.topViewController as! TodoListViewController, animated:false, with: "Show all", for: [Todo(testContext: nil)])

        XCTAssertTrue(rootView?.topViewController is TodoShowAllViewController)
    }
    
    func test_presenter_didGetCompletedTodos() {
        presenterMock.didGetCompletedTodos(todoList)
        
        XCTAssertTrue(viewMock.isHideCompletedTodosLoading)
        XCTAssertTrue(viewMock.isShowCompletedTodos)
    }
    
    func test_presenter_didGetInProgressTodos() {
        presenterMock.didGeInProgressTodos(todoList)
        
        XCTAssertTrue(viewMock.ishideInProgressTodosLoading)
        XCTAssertTrue(viewMock.isShowInProgressTodos)
    }
    
    func test_presenter_onError() {
        presenterMock.onError(VtlError.CouldNotSaveObject)
        
        XCTAssertTrue(viewMock.ishideInProgressTodosLoading)
        XCTAssertTrue(viewMock.isHideCompletedTodosLoading)
        XCTAssertTrue(viewMock.isShowError)
    }
    
    func test_sut_showInProgressTodos() {
        sut.showInProgressTodos(with: todoList)
        
        XCTAssertEqual(sut.getTodoInProgressListIsEmpty(), false)
        XCTAssertEqual(sut.getEmptyInProgressIsEmpty(), true)
    }
    
    func test_sut_showInProgressTodosEmpty() {
        sut.showInProgressTodos(with: [])
        
        XCTAssertEqual(sut.getTodoInProgressListIsEmpty(), true)
        XCTAssertEqual(sut.getEmptyInProgressIsEmpty(), false)
    }
    
    func test_sut_showInProgressTodosLoading() {
        sut.showInProgressTodosLoading()
        
        XCTAssertFalse(sut.getLoadingViewIsEmpty())
    }
    
    func test_sut_hideInProgressTodosLoading() {
        sut.hideInProgressTodosLoading()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
            
            OperationQueue.main.addOperation {
                XCTAssertTrue(self.sut.getLoadingViewIsEmpty())
            }
        })
    }
    
    func test_sut_showCompletedTodos() {
        sut.showCompletedTodos(with: todoList)
        
        XCTAssertEqual(sut.getTodoCompletedListIsEmpty(), false)
        XCTAssertEqual(sut.getEmptyCompletedIsEmpty(), true)
    }
    
    func test_sut_showCompletedTodosEmpty() {
        sut.showCompletedTodos(with: [])
        
        XCTAssertEqual(sut.getTodoCompletedListIsEmpty(), true)
        XCTAssertEqual(sut.getEmptyCompletedIsEmpty(), false)
    }
    
    func test_sut_showCompletedTodosLoading() {
        sut.showCompletedTodosLoading()
        
        XCTAssertFalse(sut.getLoadingViewIsEmpty())
    }
    
    func test_sut_hideCompletedTodosLoading() {
        sut.hideCompletedTodosLoading()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
            
            OperationQueue.main.addOperation {
                XCTAssertTrue(self.sut.getLoadingViewIsEmpty())
            }
        })
    }
    
    func test_sut_showErrorView() {
        sut.showError(error: VtlError.CouldNotSaveObject)
        
        XCTAssertFalse(sut.getErrorViewIsEmpty())
    }
    
    func test_sut_retry() {
        sut.retry()
        
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, true)
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, true)
    }
    
    func test_sut_didUpdateTodo() {
        sut.didUpdateTodo()
        
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, true)
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, true)
    }
    
    func test_sut_didDeleteTodo() {
        sut.didDeleteTodo()
        
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
        XCTAssertEqual(interactorMock.didGetCompletedTodos, true)
        XCTAssertEqual(viewMock.isShowInProgressTodosLoading, true)
        XCTAssertEqual(viewMock.isShowCompletedTodosLoading, true)
    }
    
    func test_sut_updateInProgressList() {
        sut.updateInProgressList()
        
        XCTAssertEqual(interactorMock.didGetInProgressTodos, true)
    }
    
    func test_collectionView_numberOfSections() {
        sut.loadViewIfNeeded()
        let result = sut.getListView().collectionView?.numberOfSections
        let sectionsCount = TodoListSectionType.allCases.count
        XCTAssertEqual(result, sectionsCount)
    }
    
    func test_collectionView_firstCollectionViewCellisTodoLoadingViewCell() {
        sut.loadViewIfNeeded()
        let indexPath = IndexPath(row: 0, section: 0)
        let sectionType =  sut.getListView().collectionView?.dataSource?.collectionView(sut.getListView().collectionView!, cellForItemAt: indexPath)
        XCTAssertEqual(sectionType is TodoLoadingViewCell, true)
    }
    
}
