//
//  TodoDetailsPresenter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 29/08/24.
//

import Foundation

protocol TodoDetailsPresenterProtocol: AnyObject {
    var view: TodoDetailsViewProtocol? { get set }
    var interactor: TodoDetailsInteractorProtocol? { get set }
    var todo: Todo? { get set }
    
    // View -> Presenter
    func viewDidLoad()
    func deleteTodo(todo: Todo)
    func updateTodo(todo: Todo)
}

final class TodoDetailsPresenter: TodoDetailsPresenterProtocol {

    weak var view: TodoDetailsViewProtocol?
    var interactor: TodoDetailsInteractorProtocol?
    var todo: Todo?
    
    func viewDidLoad() {
        view?.showTodoDetails(for: todo!)
    }
    
    func deleteTodo(todo: Todo) {
        interactor?.deleteTodo(todo: todo)
    }
    
    func updateTodo(todo: Todo) {
        interactor?.updateTodo(todo: todo)
    }
}

extension TodoDetailsPresenter: TodoDetailsInteractorResponseProtocol {
    func didDeleteTodo() {
        view?.didDeleteTodo()
    }
    
    func didUpdateTodo() {
        view?.didUpdateTodo()
    }
}
