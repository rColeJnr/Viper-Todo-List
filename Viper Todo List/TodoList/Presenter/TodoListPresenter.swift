//
//  TodoListPresenter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation

protocol TodoListPresenterProtocol: AnyObject {
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    
    // View -> Presenter
    func viewDidLoad()
    func getInProgressTodos()
    func createTodoCreateModule()
    func showTodoDetails(for todo: Todo)
}

class TodoListPresenter: TodoListPresenterProtocol {
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorProtocol?
    var router: TodoListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getInProgressTodos()
        interactor?.getCompletedTodos()
    }
    
    func getInProgressTodos() {
        view?.showInProgressTodosLoading()
        interactor?.getInProgressTodos()
    }
    
    func showTodoDetails(for todo: Todo) {
        router?.createTodoDetailsViewController(from: view!, for: todo)
        
    }
    
    func createTodoCreateModule() {
        router?.createTodoCreateModule(from: view!)
    }
}

extension TodoListPresenter: TodoListInteractorResponseProtocol {
    func didGetCompletedTodos(_ todos: [Todo]) {
        view?.hideCompletedTodosLoading()
        view?.showCompletedTodos(with: todos)
    }
    
    func didGetUncompletedTodos(_ todos: [Todo]) {
        view?.hideInProgressTodosLoading()
        view?.showInProgressTodos(with: todos)
    }
    
    func onError(_ error: any Error) {
        view?.hideCompletedTodosLoading()
        view?.hideInProgressTodosLoading()
        view?.showError(error: error)
    }
}
