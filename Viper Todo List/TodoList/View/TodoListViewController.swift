//
//  TodoListViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private let todoListView = TodoListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(todoListView)
    }
    
}
