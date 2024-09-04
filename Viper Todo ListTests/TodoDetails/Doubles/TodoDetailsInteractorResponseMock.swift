//
//  TodoDetailsPresenterMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

@testable import Viper_Todo_List

class TodoDetailsInteractorResponseMock: TodoDetailsInteractorResponseProtocol {
    var isTodoDeleted = false
    func didDeleteTodo() {
        isTodoDeleted = true
    }
    
    var isTodoUpdated = false
    func didUpdateTodo() {
        isTodoUpdated = true
    }
}
