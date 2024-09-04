//
//  TodoShowAllRouterMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import UIKit
@testable import Viper_Todo_List

final class TodoShowAllRouterMock: TodoShowAllRouterProtocol {
    
    func createTodoDetailsViewController(from view: any Viper_Todo_List.TodoShowAllViewProtocol, animated: Bool, for todo: Viper_Todo_List.Todo) {
        if let sourceView = view as? TodoShowAllViewController {
            sourceView.navigationController?.pushViewController(TodoDetailsViewController(), animated: false)
        }
        
    }
    
    func createModule(with title: String, for list: [Viper_Todo_List.Todo]) -> Viper_Todo_List.TodoShowAllViewController {
        let navController = TodoNavigationControllerMock(rootViewController: TodoShowAllViewController())
        return navController.topViewController as! TodoShowAllViewController
    }
    
    
}
