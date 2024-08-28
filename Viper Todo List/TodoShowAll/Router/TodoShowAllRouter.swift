//
//  TodoShowAllRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoShowAllRouterProtocol: AnyObject {
    func createTodoDetailsViewController() -> TodoDetailsViewController
    func createModule(_ title: String) -> TodoShowAllViewController
}

class TodoShowAllRouter: TodoShowAllRouterProtocol {
    
    func createTodoDetailsViewController() -> TodoDetailsViewController {
        return TodoDetailsRouter().createModule()
    }
    
    func createModule(_ title: String) -> TodoShowAllViewController {
        let viewController = TodoShowAllViewController()
        let router: TodoShowAllRouterProtocol = TodoShowAllRouter()
        viewController.router = router
        viewController.title = title
        return viewController
    }
}
