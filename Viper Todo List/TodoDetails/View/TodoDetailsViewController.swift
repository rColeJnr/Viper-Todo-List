//
//  TodoDetailsViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoDetailsViewProtocol: AnyObject {
    var presenter: TodoDetailsPresenterProtocol? { get set }
    
    // Presenter -> View
    func didUpdateTodo()
    func didDeleteTodo()
    func showTodoDetails(for todo: Todo)
}

protocol TodoDetailsViewToTodoListViewDelegate {
    func didUpdateTodo()
    func didDeleteTodo()
}

final class TodoDetailsViewController: UIViewController {
    
    let detailsView = TodoDetailsView()
    var presenter: TodoDetailsPresenterProtocol?
    var delegate: TodoDetailsViewToTodoListViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(detailsView)
        detailsView.delegate = self
        presenter?.viewDidLoad()
    }
    
}

extension TodoDetailsViewController: TodoDetailsViewProtocol, TodoDetailsViewDelegate {
    
    func updateTodo(todo: Todo) {
        presenter?.interactor?.updateTodo(todo: todo)
    }
    
    func deleteTodo(todo: Todo) {
        let ac = UIAlertController(
            title: "Delete \"\(todo.name!)\"",
            message: "Are you sure you want to delete this todo?",
            preferredStyle: .actionSheet
        )
        let cancelAction = UIAlertAction(title: "No", style: .default)
        ac.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) -> Void in
            self.presenter?.interactor?.deleteTodo(todo: todo)
        })
        ac.addAction(deleteAction)
        self.present(ac, animated: true, completion: nil)
        
    }
    
    func showTodoDetails(for todo: Todo) {
        detailsView.configure(with: todo)
    }
    
    func didUpdateTodo() {
        delegate?.didUpdateTodo()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func didDeleteTodo() {
        delegate?.didDeleteTodo()
        navigationController?.popToRootViewController(animated: true)
    }

}
 
