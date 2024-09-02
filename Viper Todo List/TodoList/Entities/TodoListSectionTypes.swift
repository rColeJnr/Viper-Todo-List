//
//  TodoListSectionTypes.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import Foundation

enum TodoListSectionType: CaseIterable {
    // It's ordered in desired ViewSection order
    case LoadingView
    case ErrorView
    case inProgressRow
    case inProgress
    case EmptyInProgress
    case completedRow
    case completed
    case EmptyCompleted
    case createNew
}

