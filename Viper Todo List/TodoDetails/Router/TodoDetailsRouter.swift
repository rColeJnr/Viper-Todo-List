//
//  TodoDetailsRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoDetailsRouterProtocol: AnyObject {
    func createModule() -> TodoDetailsViewController
    
}

class TodoDetailsRouter: TodoDetailsRouterProtocol {
    weak var viewController: UIViewController?
    
    func createModule() -> TodoDetailsViewController {
        let view = TodoDetailsViewController()
        view.title = "Описание"
        self.viewController = view
        return view
    }
}
