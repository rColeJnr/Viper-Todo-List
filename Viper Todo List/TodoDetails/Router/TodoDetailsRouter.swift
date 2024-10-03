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

final class TodoDetailsRouter: TodoDetailsRouterProtocol {
    
    func createModule(for todo: Todo) -> TodoDetailsViewController {
        let view = TodoDetailsViewController()
        var interactor: TodoDetailsInteractorProtocol & TodoDetailsLocalDataManagerResponseProtocol = TodoDetailsInteractor()
        let presenter: TodoDetailsPresenterProtocol & TodoDetailsInteractorResponseProtocol = TodoDetailsPresenter()
        var dataManager: TodoDetailsLocalDataManagerProtocol = TodoDetailsLocalDataManager()
        view.title = "Описание"
        view.presenter = presenter
        interactor.dataManager = dataManager
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.todo = todo
        dataManager.responseHandler = interactor
        return view
    }
}
