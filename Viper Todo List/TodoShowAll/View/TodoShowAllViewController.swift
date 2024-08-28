//
//  TodoShowAllViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

class TodoShowAllViewController: UIViewController, TodoShowAllViewDelegate {
    
    var router: TodoShowAllRouterProtocol?
    
    private let todoShowAllView = TodoShowAllView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        todoShowAllView.delegate = self
        setupView(todoShowAllView)
    }
    
    func didSelectTodo(with todo: Todo) {
        guard let detailsVC = router?.createTodoDetailsViewController() else {
            fatalError("DetailsVC is null")
        }
        detailsVC.todo = todo
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

