//
//  TodoListRemoteDataManagerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoListRemoteDataManagerMock: RemoteManagerProtocol {
    var remoteRequestHandler: (any Viper_Todo_List.RemoteManagerResponseProtocol)?
    
    var didFetchTodos = false
    func fetchTodos(completion: @escaping (Viper_Todo_List.VtlTodoResult) -> Void) {
        return didFetchTodos = true
    }
    
    
}
