//
//  TodoCreateDataManagerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoCreateDataManagerMock: TodoCreateLocalDataManagerProtocol {
    var responseHandler: (any Viper_Todo_List.TodoCreateLocalDataManagerResponseProtocol)?
    
    var didCreateTodo = false
    func createTodo(todo: Viper_Todo_List.TodoModel) throws {
        didCreateTodo = true
    }
    
    
}
