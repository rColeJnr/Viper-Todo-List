//
//  TodoListInteractorMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListInteractorMock: TodoListInteractorProtocol {
    var presenter: (any Viper_Todo_List.TodoListInteractorResponseProtocol)?
    
    var localDataManager: (any Viper_Todo_List.LocalDataManagerProtocol)?
    
    var remoteDataManager: (any Viper_Todo_List.RemoteManagerProtocol)?
    
    var didGetCompletedTodos = false
    func getCompletedTodos() {
        didGetCompletedTodos = true
    }
    
    var didGetInProgressTodos = false
    func getInProgressTodos() {
        didGetInProgressTodos = true
    }
    
    
}
