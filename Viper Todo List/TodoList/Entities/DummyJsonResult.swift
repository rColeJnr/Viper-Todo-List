//
//  DummyJsonResult.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation

enum DummyJsonResult {
    case success([Todo])
    case failure(Error)
}
