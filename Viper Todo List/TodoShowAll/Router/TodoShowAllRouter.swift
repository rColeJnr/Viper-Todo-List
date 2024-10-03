//
//  TodoShowAllRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoShowAllRouterProtocol: AnyObject {
    func createTodoDetailsViewController(from view: TodoShowAllViewProtocol, animated: Bool, for todo: Todo)
    func createModule(with title: String, for list: [Todo]) -> TodoShowAllViewController
}

final class TodoShowAllRouter: TodoShowAllRouterProtocol {
    
    // Passing animated as Bool for testing
    func createTodoDetailsViewController(from view: TodoShowAllViewProtocol, animated: Bool = true, for todo: Todo) {
        let detailsVC = TodoDetailsRouter().createModule(for: todo)
        if let sourceView = view as? TodoShowAllViewController {
            sourceView.navigationController?.pushViewController(detailsVC, animated: animated)
        }
    }
    
    func createModule(with title: String, for list: [Todo]) -> TodoShowAllViewController {
        let viewController = TodoShowAllViewController()
        var presenter: TodoShowAllPresenterProtocol = TodoShowAllPresenter()
        viewController.presenter = presenter
        presenter.view =  viewController
        presenter.todoList = list
        viewController.title = title
        return viewController
    }
}
