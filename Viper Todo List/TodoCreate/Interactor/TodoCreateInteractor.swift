//
//  TodoCreateInteractor.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

protocol TodoCreateInteractorProtocol {
    var presenter: TodoCreateInteractorResponseProtocol? { get set }
    var dataManager: TodoCreateLocalDataManagerProtocol? { get set }
    func createTodo(todo: TodoModel)
}

protocol TodoCreateInteractorResponseProtocol {
    func didCreateTodo()
}

final class TodoCreateInteractor: TodoCreateInteractorProtocol {
    
    var presenter: TodoCreateInteractorResponseProtocol?
    var dataManager: TodoCreateLocalDataManagerProtocol?
    
    func createTodo(todo: TodoModel) {
        do {
            try dataManager?.createTodo(todo: todo)
        } catch {
            print("Error saving to core data \(error.localizedDescription)")
            return
        }
    }
}

extension TodoCreateInteractor: TodoCreateLocalDataManagerResponseProtocol {
    func didCreateTodo() {
        presenter?.didCreateTodo()
    }
}

