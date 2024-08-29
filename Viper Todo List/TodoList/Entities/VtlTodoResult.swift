//
//  DummyJsonResult.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation

enum VtlTodoResult {
    case success([Todo])
    case failure(Error)
}
