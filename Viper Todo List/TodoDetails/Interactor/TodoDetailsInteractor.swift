//
//  TodoDetailsInteractor.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

protocol TodoDetailsInteractorProtocol {
    var presenter: TodoDetailsInteractorResponseProtocol? { get set }
    var dataManager: TodoDetailsLocalDataManagerProtocol? { get set }
    func deleteTodo(todo: Todo)
    func updateTodo(todo: Todo)
}

protocol TodoDetailsInteractorResponseProtocol {
    func didDeleteTodo()
    func didUpdateTodo()
}

final class TodoDetailsInteractor: TodoDetailsInteractorProtocol {
    var presenter: TodoDetailsInteractorResponseProtocol?
    var dataManager: TodoDetailsLocalDataManagerProtocol?
    
    func deleteTodo(todo: Todo) {
        dataManager?.deleteTodo(todo: todo)
    }
    
    func updateTodo(todo: Todo) {
        dataManager?.updateTodo(todo: todo)
    }
    
}

extension TodoDetailsInteractor: TodoDetailsLocalDataManagerResponseProtocol {
    func didDeleteTodo() {
        presenter?.didDeleteTodo()
    }
    
    func didUpdateTodo() {
        presenter?.didUpdateTodo()
    }
}
