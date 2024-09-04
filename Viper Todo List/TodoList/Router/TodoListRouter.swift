//
//  TodoListRouter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoListRouterProtocol: AnyObject {
    // Presenter -> Router
    func createTodoDetailsViewController(from view: TodoListViewProtocol, for todo: Todo)
    func createTodoShowAllViewController(from view: TodoListViewProtocol, with title: String, for list: [Todo])
    func createTodoCreateModule(from view: TodoListViewProtocol)
    
    func createModule() -> UINavigationController
    
}
class TodoListRouter: TodoListRouterProtocol {
    
    func createTodoCreateModule(from view: any TodoListViewProtocol) {
        let createVc = TodoCreateRouter().createModule()
    
        if let sourceView = view as? TodoListViewController {
            createVc.delegate = sourceView.self
            sourceView.navigationController?.pushViewController(createVc, animated: false)
        }
    }
        
    func createTodoDetailsViewController(from view: TodoListViewProtocol, for todo: Todo) {
        let detailsVC = TodoDetailsRouter().createModule(for: todo)
        
        if let sourceView = view as? TodoListViewController {
            detailsVC.delegate = sourceView.self
            sourceView.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func createTodoShowAllViewController(from view: TodoListViewProtocol, with title: String, for list: [Todo]) {
        let showAllVC = TodoShowAllRouter().createModule(with: title, for: list)
        if let sourceView = view as? TodoListViewController {
            sourceView.navigationController?.pushViewController(showAllVC, animated: true)
        }
    }
    
    func createModule() -> UINavigationController {
        let view = TodoListViewController()
        let presenter: TodoListPresenterProtocol & TodoListInteractorResponseProtocol = TodoListPresenter()
        var interactor: TodoListInteractorProtocol & RemoteManagerResponseProtocol = TodoListInteractor()
        let localDataManager: LocalDataManagerProtocol = LocalDataManager()
        var remoteDataManager: RemoteManagerProtocol = RemoteDataManager()
        let router: TodoListRouterProtocol = TodoListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        view.title = "Задачи"
        let navController = UINavigationController(rootViewController: view)
        return navController
    }
}
