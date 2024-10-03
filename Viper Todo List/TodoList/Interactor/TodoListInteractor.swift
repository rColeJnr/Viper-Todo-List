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
    func didGeInProgressTodos(_ todos: [Todo])
    func onError(_ error: Error)
}

// Here is were we going to check if first run
final class TodoListInteractor: TodoListInteractorProtocol {
    
    var presenter: TodoListInteractorResponseProtocol?
    var localDataManager: LocalDataManagerProtocol?
    var remoteDataManager: RemoteManagerProtocol?
    
    func getCompletedTodos() {
        if VtlUserDefaults.shared.didLoadInitialJson() {
            remoteDataManager?.fetchTodos(completion: { [weak self] result in
                switch result {
                case .success(let todos):
                    self?.presenter?.didGetCompletedTodos(todos) //Update completed list
                    self?.presenter?.didGeInProgressTodos(todos) // Update inProgress list
                case .failure(let error):
                    self?.presenter?.onError(error)
                }
            })
        }
        localDataManager?.getCompletedTodos(completion: { [weak self] todoResult in
            switch todoResult {
            case .success(let todos):
                self?.presenter?.didGetCompletedTodos(todos)
            case .failure(let error):
                self?.presenter?.onError(error)
            }
        })
    }
    
    func getInProgressTodos() {
        localDataManager?.getInProgressTodos(completion: { [weak self] todoResult in
            switch todoResult {
            case .success(let todos):
                self?.presenter?.didGeInProgressTodos(todos)
            case .failure(let error):
                self?.presenter?.onError(error)
            }
        })
    }
    
}

extension TodoListInteractor: RemoteManagerResponseProtocol {
    
    func didGetTodos(_ todos: [Todo]) {
        presenter?.didGetCompletedTodos(todos.filter({it in it.completed}))
        presenter?.didGeInProgressTodos(todos.filter({it in !it.completed}))
    }
    
    func onError(_ error: any Error) {
        presenter?.onError(error)
    }

}
