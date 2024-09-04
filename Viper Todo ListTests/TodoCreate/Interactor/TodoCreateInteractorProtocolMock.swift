//
//  TodoCreateInteractorProtocolMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoCreateInteractorProtocolMock: TodoCreateInteractorProtocol {
    
    var presenter: (any Viper_Todo_List.TodoCreateInteractorResponseProtocol)?
    
    var dataManager: (any Viper_Todo_List.TodoCreateLocalDataManagerProtocol)?
    
    func createTodo(todo: Viper_Todo_List.TodoModel) {
        <#code#>
    }
    
    
}
