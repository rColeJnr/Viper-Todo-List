//
//  TodoDetailsViewMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

class TodoDetailsViewMock: TodoDetailsViewProtocol {
    var presenter: (any Viper_Todo_List.TodoDetailsPresenterProtocol)?
    
    var isTodoUpdated = false
    func didUpdateTodo() {
        isTodoUpdated = true
    }
    
    var isTodoDeleted = false
    func didDeleteTodo() {
        isTodoDeleted = true
    }
    
    var didShowTodoDetails = false
    func showTodoDetails(for todo: Viper_Todo_List.Todo) {
        didShowTodoDetails = true
    }
    
}
