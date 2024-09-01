//
//  TodoCreatePresenter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

protocol TodoCreatePresenterProtocol {
    var view: TodoCreateViewProtocol? { get set }
    var interactor: TodoCreateInteractorProtocol? { get set }
    var router: TodoCreateRouterProtocol? { get set }
    
    func createTodo(todo: TodoModel)
}

class TodoCreatePresenter: TodoCreatePresenterProtocol {
   
    weak var view: TodoCreateViewProtocol?
    
    var interactor: TodoCreateInteractorProtocol?
    
    var router: TodoCreateRouterProtocol?
    
    func createTodo(todo: TodoModel) {
        interactor?.createTodo(todo: todo)
    }
}

extension TodoCreatePresenter: TodoCreateInteractorResponseProtocol {
    func didCreateTodo() {
        print("problema de nao saber")
        view?.didCreateTodo()
    }
}
