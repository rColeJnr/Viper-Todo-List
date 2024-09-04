//
//  TodoCreateInteratorResponseMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import Foundation
@testable import Viper_Todo_List

class TodoCreateInteratorResponseMock: TodoCreateInteractorResponseProtocol {
    
    var isTodoCreated = false
    func didCreateTodo() {
        isTodoCreated = true
    }
    
}
