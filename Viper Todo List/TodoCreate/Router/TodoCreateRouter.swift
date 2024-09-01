//
//  TodoCreateRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

protocol TodoCreateRouterProtocol {
    func createModule() -> TodoCreateViewController
}

class TodoCreateRouter: TodoCreateRouterProtocol {
    
    func createModule() -> TodoCreateViewController {
        let view = TodoCreateViewController()
        var presenter: TodoCreatePresenterProtocol & TodoCreateInteractorResponseProtocol = TodoCreatePresenter()
        var interactor: TodoCreateInteractorProtocol & TodoCreateLocalDataManagerResponseProtocol  = TodoCreateInteractor()
        var dataManager: TodoCreateLocalDataManagerProtocol = TodoCreateLocalDataManager()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        dataManager.responseHandler = interactor
        view.title = "Create a todo"
        return view
    }
}
