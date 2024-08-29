//
//  TodoListViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

protocol NavigateToShowAllViewCellDelegate: AnyObject {
    func navigateToShowAll(_ title: String)
}

protocol TodoListViewProtocol: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set }
    
    // Presenter -> View
    func showUncompletedTodos(with todos: [Todo])
    
    func showUncompletedLoading()
    
    func hideUncompletedLoading()
    
    func showCompletedTodos(with todos: [Todo])
    
    func showCompletedLoading()
    
    func hideCompletedLoading()
    
    func showError(error: Error)
}

class TodoListViewController: UIViewController, NavigateToShowAllViewCellDelegate {

    private let todoListView = TodoListView()
    var presenter: TodoListPresenterProtocol?
    var todoUncompletedList: [Todo] = []
    var todoCompletedList: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(todoListView)
        
        todoListView.collectionView?.delegate = self
        todoListView.collectionView?.dataSource = self
    
    }
    
    func navigateToShowAll(_ title: String) {
        presenter?.router?.createTodoShowAllViewController(from: self, title)
    }
    
}

extension TodoListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TodoListSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = TodoListSectionType.allCases[section]
        switch sectionType {
        case .uncompleted:
            return todoUncompletedList.count
        case .completed:
            return todoCompletedList.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = TodoListSectionType.allCases[indexPath.section]
        switch sectionType {
        
        case .completed:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCompleteViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCompleteViewCell else {
                fatalError()
            }
            cell.configure(todo: todoCompletedList[indexPath.row])
            return cell
            
        case .uncompleted:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoUncompleteViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoUncompleteViewCell else {
                fatalError()
            }
            cell.configure(todo: todoUncompletedList[indexPath.row])
            return cell
        
        case .completedRow:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCompleteRowViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCompleteRowViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        
        case .uncompletedRow:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoUncompleteRowViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoUncompleteRowViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
            
        case .createNew:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCreateNewViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCreateNewViewCell else {
                fatalError()
            }
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCompleteViewCell.cellIdentifier, for: indexPath) as? TodoCompleteViewCell {
                let todo = todoCompletedList[indexPath.row]
                presenter?.showTodoDetails(for: todo)
        } else {
            let todo = todoUncompletedList[indexPath.row]
            presenter?.showTodoDetails(for: todo)
        }
    }
    
}

extension TodoListViewController: TodoListViewProtocol {
    func showUncompletedTodos(with todos: [Todo]) {
        todoUncompletedList = todos
    }
    
    func showUncompletedLoading() {
        // not implemented yet
    }
    
    func hideUncompletedLoading() {
        // not implemented yet
    }
    
    func showCompletedTodos(with todos: [Todo]) {
        todoCompletedList = todos
    }
    
    func showCompletedLoading() {
        // not implemented yet
    }
    
    func hideCompletedLoading() {
        // not implemented yet
    }
    
    func showError(error: any Error) {
        print("failed to load with error: \(error.localizedDescription)")
        // not implemented yet
    }
    
    
}
