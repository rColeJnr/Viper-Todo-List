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
    func showTodoDetails(for todo: Todo)
}

class TodoListPresenter: TodoListPresenterProtocol {
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorProtocol?
    var router: TodoListRouterProtocol?
    
    func viewDidLoad() {
        view?.showUncompletedLoading()
        view?.showCompletedLoading()
        interactor?.getUncompletedTodos()
        interactor?.getCompletedTodos()
    }
    
    func showTodoDetails(for todo: Todo) {
        router?.createTodoDetailsViewController(from: view!, for: todo)
        
    }
}

extension TodoListPresenter: TodoListInteractorResponseProtocol {
    func didGetCompletedTodos(_ todos: [Todo]) {
        view?.hideCompletedLoading()
        view?.showCompletedTodos(with: todos)
    }
    
    func didGetUncompletedTodos(_ todos: [Todo]) {
        view?.hideUncompletedLoading()
        view?.showUncompletedTodos(with: todos)
    }
    
    func onError(_ error: any Error) {
        view?.hideCompletedLoading()
        view?.hideUncompletedLoading()
        view?.showError(error: error)
    }
}
