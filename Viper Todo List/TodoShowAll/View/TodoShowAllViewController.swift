//
//  TodoShowAllViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoShowAllViewProtocol: AnyObject {
    var presenter: TodoShowAllPresenterProtocol? { get set }
    
    // Presenter -> View
    func showTodoList(for list: [Todo])
}

class TodoShowAllViewController: UIViewController, TodoShowAllViewDelegate, TodoShowAllViewProtocol {
    
    var presenter: TodoShowAllPresenterProtocol?
    
    private let todoShowAllView = TodoShowAllView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        todoShowAllView.delegate = self
        todoShowAllView.startAnimatingIndicatorView()
        setupView(todoShowAllView)
        presenter?.viewDidLoad()
    }
    
    func didSelectTodo(with todo: Todo) {
        presenter?.router?.createTodoDetailsViewController(from: self, for: todo)
    }
    
    func showTodoList(for list: [Todo]) {
        todoShowAllView.stopAnimatingIndicatorView()
        if list.isEmpty {
            todoShowAllView.showEmptyView()
        } else {
            todoShowAllView.todoList = list
        }
    }
    
}
