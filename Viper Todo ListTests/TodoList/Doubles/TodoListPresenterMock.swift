//
//  TodoListPresenterMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 05/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListPresenterMock: TodoListPresenterProtocol {
    var view: (any Viper_Todo_List.TodoListViewProtocol)? = TodoListViewMock()
    
    var interactor: (any Viper_Todo_List.TodoListInteractorProtocol)? = TodoListInteractorMock()
    
    var router: (any Viper_Todo_List.TodoListRouterProtocol)? = TodoListRouterMock()
    
    
    func viewDidLoad() {
        view?.showInProgressTodosLoading()
        view?.showCompletedTodosLoading()
        interactor?.getInProgressTodos()
        interactor?.getCompletedTodos()
    }
    
    func getInProgressTodos() {
        view?.showInProgressTodosLoading()
        interactor?.getInProgressTodos()
    }
    
    func createTodoCreateModule(from view: any Viper_Todo_List.TodoListViewProtocol) {
        router?.createTodoCreateModule(from: view, animated: false)
    }
    
    func showTodoDetails(from view: any Viper_Todo_List.TodoListViewProtocol, for todo: Viper_Todo_List.Todo) {
        router?.createTodoDetailsViewController(from: view, animated: false, for: todo)
    }
    
    
}

extension TodoListPresenterMock: TodoListInteractorResponseProtocol {
    
    func didGetCompletedTodos(_ todos: [Viper_Todo_List.Todo]) {
        view?.hideCompletedTodosLoading()
        view?.showCompletedTodos(with: todos)
    }
    
    func didGeInProgressTodos(_ todos: [Viper_Todo_List.Todo]) {
        view?.hideInProgressTodosLoading()
        view?.showInProgressTodos(with: todos)
    }
    
    func onError(_ error: any Error) {
        view?.hideCompletedTodosLoading()
        view?.hideInProgressTodosLoading()
        view?.showError(error: VtlError.CouldNotSaveObject)
    }
    
}
