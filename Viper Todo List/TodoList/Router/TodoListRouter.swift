//
//  TodoListRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoListRouterProtocol: AnyObject {
    func createTodoDetailsViewController() -> TodoDetailsViewController
    func createTodoShowAllViewController(_ title: String) -> TodoShowAllViewController
    func createModule() -> TodoListViewController
    
}
class TodoListRouter: TodoListRouterProtocol {
    weak var viewController: UIViewController?
    
    func createTodoDetailsViewController() -> TodoDetailsViewController {
        return TodoDetailsRouter().createModule()
    }
    
    func createTodoShowAllViewController(_ title: String) -> TodoShowAllViewController {
        return TodoShowAllRouter().createModule(title)
    }
    
    func createModule() -> TodoListViewController {
        let view = TodoListViewController()
        let router: TodoListRouterProtocol = TodoListRouter()
        view.router = router
        view.title = "Задачи"
        self.viewController = view
        return view
    }
}
