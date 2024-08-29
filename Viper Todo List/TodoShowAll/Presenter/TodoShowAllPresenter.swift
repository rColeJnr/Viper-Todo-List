//
//  TodoShowAllPresenter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 29/08/24.
//

import Foundation

protocol TodoShowAllPresenterProtocol {
    var view: TodoShowAllViewProtocol? { get set }
    var router: TodoShowAllRouterProtocol? { get set }
    var todoList: [Todo]? { get set }
    
    // view -> Presenter
    func viewDidLoad()
}

class TodoShowAllPresenter: TodoShowAllPresenterProtocol {
    
    weak var view: TodoShowAllViewProtocol?
    var router: TodoShowAllRouterProtocol?
    var todoList: [Todo]?
    
    func viewDidLoad() {
        view?.showTodoList(for: todoList!)
    }
}
