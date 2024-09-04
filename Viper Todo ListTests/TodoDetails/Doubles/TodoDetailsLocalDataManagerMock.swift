//
//  TodoDetailsLocalDataManagerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

class TodoDetailsLocalDataManagerMock: TodoDetailsLocalDataManagerProtocol {
    var responseHandler: (any Viper_Todo_List.TodoDetailsLocalDataManagerResponseProtocol)?
    
    var didDeleteTodo = false
    func deleteTodo(todo: Viper_Todo_List.Todo) {
        didDeleteTodo = true
    }
    
    var didUpdateTodo = false
    func updateTodo(todo: Viper_Todo_List.Todo) {
        didUpdateTodo = true
    }
}
