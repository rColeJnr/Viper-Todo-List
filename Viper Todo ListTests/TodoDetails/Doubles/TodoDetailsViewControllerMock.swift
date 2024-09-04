//
//  TodoDetailsViewControllerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

@testable import Viper_Todo_List
import UIKit

final class TodoDetailsViewControllerMock: TodoDetailsViewDelegate {
    
    var didUpdateTodo = false
    func updateTodo(todo: Viper_Todo_List.Todo) {
        didUpdateTodo = true
    }
    
    var didDeleteTodo = false
    func deleteTodo(todo: Viper_Todo_List.Todo) {
        didDeleteTodo = true
    }

}
