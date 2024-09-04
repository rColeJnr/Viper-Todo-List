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
    
    // Fetch data and update both list on viewDidLoad(), onUpdateTodo() and onDeleteTodo()
    func viewDidLoad() {
        view?.showInProgressTodosLoading()
        view?.showCompletedTodosLoading()
        interactor?.getInProgressTodos()
        interactor?.getCompletedTodos()
    }
    
    // Fetch data and update inProgress list after creating a new todo
    func getInProgressTodos() {
        view?.showInProgressTodosLoading()
        interactor?.getInProgressTodos()
    }
    
    func showTodoDetails(for todo: Todo) {
        router?.createTodoDetailsViewController(from: view!, animated: true, for: todo)
        
    }
    
    func createTodoCreateModule() {
        router?.createTodoCreateModule(from: view!, animated: true)
    }
}

extension TodoListPresenter: TodoListInteractorResponseProtocol {
    func didGetCompletedTodos(_ todos: [Todo]) {
        view?.hideCompletedTodosLoading()
        view?.showCompletedTodos(with: todos)
    }
    
    func didGeInProgressTodos(_ todos: [Todo]) {
        view?.hideInProgressTodosLoading()
        view?.showInProgressTodos(with: todos)
    }
    
    func onError(_ error: any Error) {
        view?.hideCompletedTodosLoading()
        view?.hideInProgressTodosLoading()
        view?.showError(error: error)
    }
}
