//
//  TodoDetailsViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

class TodoDetailsViewController: UIViewController {
    
    private var detailsView = TodoDetailsView()
    
    var todo: Todo! {
        didSet {
            detailsView.configure(todo: todo)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(detailsView)
    }
    
}
