//
//  TodoCreateViewMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

final class TodoCreateViewMock: TodoCreateViewProtocol {
    var presenter: (any Viper_Todo_List.TodoCreatePresenterProtocol)?
    
    var isTodoCreated = false
    func didCreateTodo() {
        isTodoCreated = true
    }
    
}
