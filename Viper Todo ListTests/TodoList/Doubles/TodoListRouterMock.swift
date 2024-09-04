//
//  TodoListRouterMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import UIKit
@testable import Viper_Todo_List

class TodoListRouterMock: TodoListRouterProtocol {
    func createTodoDetailsViewController(from view: any Viper_Todo_List.TodoListViewProtocol, animated: Bool, for todo: Viper_Todo_List.Todo) {
        let detailsView = TodoDetailsRouter().createModule(for: todo)
        
        if let sourceView = view as? TodoListViewController {
            sourceView.navigationController?.pushViewController(detailsView, animated: false)
        }
    }
    
    func createTodoShowAllViewController(from view: any Viper_Todo_List.TodoListViewProtocol, animated: Bool, with title: String, for list: [Viper_Todo_List.Todo]) {
        let showAllView = TodoShowAllRouter().createModule(with: "Show all", for: list)
        
        if let sourceView = view as? TodoListViewController {
            sourceView.navigationController?.pushViewController(showAllView, animated: false)
        }
    }
    
    func createTodoCreateModule(from view: any Viper_Todo_List.TodoListViewProtocol, animated: Bool) {
        let createView = TodoCreateRouter().createModule()
        
        if let sourceView = view as? TodoListViewController {
            sourceView.navigationController?.pushViewController(createView, animated: false)
        }
    }
    
    func createModule() -> UINavigationController {
        return TodoNavigationControllerMock(rootViewController: TodoListViewController())
    }
    
    
}
