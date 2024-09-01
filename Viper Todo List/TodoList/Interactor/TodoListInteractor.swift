//
//  TodoListInteractor.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation

protocol TodoListInteractorProtocol {
    var presenter: TodoListInteractorResponseProtocol? { get set }
    var localDataManager: LocalDataManagerProtocol? { get set }
    var remoteDataManager: RemoteManagerProtocol? { get set }
    
    // Presenter -> Interactor
    func getCompletedTodos()
    func getInProgressTodos()
}

protocol TodoListInteractorResponseProtocol {
    // Interactor -> Presenter
    func didGetCompletedTodos(_ todos: [Todo])
    func didGetUncompletedTodos(_ todos: [Todo])
    func onError(_ error: Error)
}

// Here is were we going to check if first run
class TodoListInteractor: TodoListInteractorProtocol {
    
    var presenter: TodoListInteractorResponseProtocol?
    var localDataManager: LocalDataManagerProtocol?
    var remoteDataManager: RemoteManagerProtocol?
    
    // We must only fetch dummy json on first run, this code doesnt' work like that
    func getCompletedTodos() {
        localDataManager?.getCompletedTodos(completion: { [weak self] todoResult in
            switch todoResult {
            case .success(let todos):
                if todos.isEmpty {
                    self?.remoteDataManager?.fetchTodos(completion: { [weak self] result in
                        switch result {
                        case .success(let array):
                            print(array.count)
                            self?.presenter?.didGetCompletedTodos(array)
                        case .failure(let error):
                            self?.presenter?.onError(error)
                        }
                    })
                } else {
                    self?.presenter?.didGetCompletedTodos(todos)
                }
            case .failure(let error):
                self?.presenter?.onError(error)
            }
        })
    }
    
    func getInProgressTodos() {
        localDataManager?.getInProgreeTodos(completion: { [weak self] todoResult in
            switch todoResult {
            case .success(let todos):
                if todos.isEmpty {
                    self?.remoteDataManager?.fetchTodos(completion: { [weak self] result in
                        switch result {
                        case .success(let array):
                            self?.presenter?.didGetUncompletedTodos(array)
                        case .failure(let error):
                            self?.presenter?.onError(error)
                        }
                    })
                } else {
                    self?.presenter?.didGetUncompletedTodos(todos)
                }
            case .failure(let error):
                self?.presenter?.onError(error)
            }
        })
    } 
}


extension TodoListInteractor: RemoteManagerResponseProtocol {
    
    func didGetCompletedTodos(_ todos: [Todo]) {
        presenter?.didGetCompletedTodos(todos)
    }
    
    func didGetInProgressTodos(_ todos: [Todo]) {
        presenter?.didGetUncompletedTodos(todos)
    }

    func onError(_ error: any Error) {
        presenter?.onError(error)
    }

}
