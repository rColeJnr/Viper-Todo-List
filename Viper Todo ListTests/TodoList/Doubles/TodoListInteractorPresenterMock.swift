//
//  TodoListPresenterMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListInteractorPresenterMock: TodoListInteractorResponseProtocol {
    
    var didDidGetCompletedTodos = false
    func didGetCompletedTodos(_ todos: [Viper_Todo_List.Todo]) {
        if !todos.isEmpty {
            didDidGetCompletedTodos = true
        }
    }
    
    var didDidGetInProgressTodos = false
    func didGeInProgressTodos(_ todos: [Viper_Todo_List.Todo]) {
        if !todos.isEmpty {
            didDidGetInProgressTodos = true
        }
    }
    
    var didOnError = false
    func onError(_ error: any Error) {
        if error is VtlError {
            didOnError = true
        }
    }
    

    
}
