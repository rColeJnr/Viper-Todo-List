//
//  TodoShowAllViewMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoShowAllViewMock: TodoShowAllViewProtocol {
    var presenter: (any Viper_Todo_List.TodoShowAllPresenterProtocol)?
    
    var receivedTodoList = false
    func showTodoList(for list: [Viper_Todo_List.Todo]) {
        if !list.isEmpty {
            receivedTodoList = true
        }
    }
    
    
}
