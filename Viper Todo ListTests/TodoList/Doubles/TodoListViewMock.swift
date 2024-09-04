//
//  TodoListViewMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListViewMock: TodoListViewProtocol {
    var presenter: (any Viper_Todo_List.TodoListPresenterProtocol)?
    
    var isShowInProgressTodos = false
    func showInProgressTodos(with todos: [Viper_Todo_List.Todo]) {
        if !todos.isEmpty {
            isShowInProgressTodos = true
        }
    }
    
    var isShowInProgressTodosLoading = false
    func showInProgressTodosLoading() {
        isShowInProgressTodosLoading = true
    }
    
    var ishideInProgressTodosLoading = false
    func hideInProgressTodosLoading() {
        ishideInProgressTodosLoading = true
    }
    
    var isShowCompletedTodos = false
    func showCompletedTodos(with todos: [Viper_Todo_List.Todo]) {
        if !todos.isEmpty{
            isShowCompletedTodos = true
        }
    }
    
    var isShowCompletedTodosLoading = false
    func showCompletedTodosLoading() {
        isShowCompletedTodosLoading = true
    }
    
    var isHideCompletedTodosLoading = false
    func hideCompletedTodosLoading() {
        isHideCompletedTodosLoading = true
    }
    
    var isShowError = false
    func showError(error: any Error) {
        if error is VtlError {
            isShowError = true
        }
    }
    
}
