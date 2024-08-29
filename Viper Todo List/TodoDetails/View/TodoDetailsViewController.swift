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
    func showTodoDetails(for todo: Todo)
}

class TodoDetailsViewController: UIViewController, TodoDetailsViewProtocol {
    
    private var detailsView = TodoDetailsView()
    var presenter: TodoDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(detailsView)
        presenter?.viewDidLoad()
    }
    
    func showTodoDetails(for todo: Todo) {
        detailsView.configure(with: todo)
    }
    
}
