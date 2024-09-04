//
//  TodoDetailsLocalInteractorMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

class TodoDetailsInteractorMock: TodoDetailsInteractorProtocol {
    var presenter: (any Viper_Todo_List.TodoDetailsInteractorResponseProtocol)?
    
    var dataManager: TodoDetailsLocalDataManagerProtocol? = TodoDetailsLocalDataManagerMock()
    
    var isTodoDeleted = false
    func deleteTodo(todo: Viper_Todo_List.Todo) {
        isTodoDeleted = true
    }
    
    var isTodoUpdated = false
    func updateTodo(todo: Viper_Todo_List.Todo) {
        isTodoUpdated = true
    }
    
    
}
