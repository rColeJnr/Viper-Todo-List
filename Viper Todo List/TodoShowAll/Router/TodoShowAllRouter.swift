//
//  TodoShowAllRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoShowAllRouterProtocol: AnyObject {
    func createTodoDetailsViewController(from view: TodoShowAllViewProtocol, for todo: Todo)
    func createModule(with title: String, for list: [Todo]) -> TodoShowAllViewController
}

class TodoShowAllRouter: TodoShowAllRouterProtocol {
    
    func createTodoDetailsViewController(from view: TodoShowAllViewProtocol, for todo: Todo) {
        let detailsVC = TodoDetailsRouter().createModule(for: todo)
        
        if let sourceView = view as? TodoShowAllViewController {
            sourceView.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func createModule(with title: String, for list: [Todo]) -> TodoShowAllViewController {
        let viewController = TodoShowAllViewController()
        
        var presenter: TodoShowAllPresenterProtocol = TodoShowAllPresenter()
        let router: TodoShowAllRouterProtocol = TodoShowAllRouter()
        viewController.presenter = presenter
        presenter.view =  viewController
        presenter.todoList = list
        presenter.router = router
        viewController.title = title
        return viewController
    }
}
