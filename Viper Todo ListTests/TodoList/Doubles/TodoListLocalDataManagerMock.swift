//
//  TodoListLocalDataManagerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListLocalDataManagerMock: LocalDataManagerProtocol {
    var didGetCompletedTodos = false
    func getCompletedTodos(completion: @escaping (Viper_Todo_List.VtlTodoResult) -> Void) {
        didGetCompletedTodos = true
    }
    
    var didGetInProgressTodos = false
    func getInProgressTodos(completion: @escaping (Viper_Todo_List.VtlTodoResult) -> Void) {
        didGetInProgressTodos = true
    }
    
    
}
