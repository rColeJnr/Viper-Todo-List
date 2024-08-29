//
//  TodoDetailsPresenter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 29/08/24.
//

import Foundation

protocol TodoDetailsPresenterProtocol: AnyObject {
    var view: TodoDetailsViewProtocol? { get set }
    var router: TodoDetailsRouterProtocol? { get set }
    var todo: Todo? { get set }
    
    // View -> Presenter
    func viewDidLoad()
}

class TodoDetailsPresenter: TodoDetailsPresenterProtocol {

    weak var view: TodoDetailsViewProtocol?
    var router: TodoDetailsRouterProtocol?
    var todo: Todo?
    
    func viewDidLoad() {
        view?.showTodoDetails(for: todo!)
    }
}
