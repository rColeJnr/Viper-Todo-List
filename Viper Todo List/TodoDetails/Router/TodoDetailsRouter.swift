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
    weak var viewController: UIViewController?
    
    func createModule(for todo: Todo) -> TodoDetailsViewController {
        let view = TodoDetailsViewController()
        view.todo = todo
        view.title = "Описание"
        self.viewController = view
        return view
    }
}
