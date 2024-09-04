//
//  TodoModel.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

struct TodoModel: Equatable {
    let name: String
    let details: String
    let completed: Bool
    let dateCreated: Date
    var dateCompleted: Date?
    
    init(name: String, details: String, completed: Bool, dateCreated: Date, dateCompleted: Date? = nil) {
        self.name = name
        self.details = details
        self.completed = completed
        self.dateCreated = dateCreated
        self.dateCompleted = dateCompleted
    }
    
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        return lhs.name == rhs.name
    }
    
}
