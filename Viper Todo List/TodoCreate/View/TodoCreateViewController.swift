//
//  TodoCreateViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import UIKit

protocol TodoCreateViewProtocol: AnyObject {
    var presenter: TodoCreatePresenterProtocol? { get set }
    
    func didCreateTodo()
}

protocol TodoCreateViewToTodoListViewDelegate {
    func updateTodoList()
}

class TodoCreateViewController: UIViewController {
    
    var presenter: TodoCreatePresenterProtocol?
    var delegate: TodoCreateViewToTodoListViewDelegate?
    private let todoCreateView = TodoCreateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoCreateView.delegate = self
        setupView(todoCreateView)
    }
    
}

extension TodoCreateViewController: TodoCreateViewProtocol, TodoCreateViewDelegate {
    
    func didCreateTodo() {
        print("Did create todo")
        delegate?.updateTodoList()
    }
    
    func createNewTodo(for todo: TodoModel) {
        presenter?.interactor?.createTodo(todo: todo)
        navigationController?.popViewController(animated: true)
    }
    
}
