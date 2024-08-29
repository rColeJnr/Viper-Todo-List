//
//  TodoDetailsRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoDetailsRouterProtocol: AnyObject {
    func createModule(for todo: Todo) -> TodoDetailsViewController
    
}

class TodoDetailsRouter: TodoDetailsRouterProtocol {
    
    func createModule(for todo: Todo) -> TodoDetailsViewController {
        let view = TodoDetailsViewController()
        let presenter: TodoDetailsPresenterProtocol = TodoDetailsPresenter()
        let router: TodoDetailsRouterProtocol = TodoDetailsRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.todo = todo
        presenter.router = router
        view.title = "Описание"
        return view
    }
}
