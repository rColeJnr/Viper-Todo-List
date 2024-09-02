//
//  TodoListViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

protocol NavigateToShowAllViewCellDelegate: AnyObject {
    func navigateToShowAll(_ title: String, completed flag: Bool)
}

protocol TodoListViewProtocol: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set }
    
    // Presenter -> View
    func showInProgressTodos(with todos: [Todo])
    
    func showInProgressTodosLoading()
    
    func hideInProgressTodosLoading()
    
    func showCompletedTodos(with todos: [Todo])
    
    func showCompletedTodosLoading()
    
    func hideCompletedTodosLoading()
    
    func showError(error: Error)
}
// MARK: - VIEW
class TodoListViewController: UIViewController {

    private let todoListView = TodoListView()
    var presenter: TodoListPresenterProtocol?
    var todoInprogressList: [Todo] = []
    var todoCompletedList: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(todoListView)
        presenter?.viewDidLoad()
        todoListView.collectionView?.delegate = self
        todoListView.collectionView?.dataSource = self
    }
}

// MARK: - COLLECTION VIEW

extension TodoListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TodoListSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = TodoListSectionType.allCases[section]
        switch sectionType {
        case .inProgress:
            return todoInprogressList.count
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
            
        case .inProgress:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: todoInProgreessViewCell.cellIdentifier,
                for: indexPath
            ) as? todoInProgreessViewCell else {
                fatalError()
            }
            cell.configure(todo: todoInprogressList[indexPath.row])
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
        
        case .inProgressRow:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoInProgressRowViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoInProgressRowViewCell else {
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
            cell.delegate = self
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = TodoListSectionType.allCases[indexPath.section]
        switch sectionType {
            
        case .completed:
            guard collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCompleteViewCell.cellIdentifier,
                for: indexPath
            ) is TodoCompleteViewCell else {
                fatalError()
            }
            let todo = todoCompletedList[indexPath.row]
            presenter?.showTodoDetails(for: todo)
            
        case .inProgress:
            guard collectionView.dequeueReusableCell(
                withReuseIdentifier: todoInProgreessViewCell.cellIdentifier,
                for: indexPath
            ) is todoInProgreessViewCell else {
                fatalError()
            }
            let todo = todoInprogressList[indexPath.row]
            presenter?.showTodoDetails(for: todo)
        
        default:
            return
            // do nothing
        }
    }
    
}

// MARK: - VIEW PROTOCOL
extension TodoListViewController: TodoListViewProtocol {
    func showInProgressTodos(with todos: [Todo]) {
        todoInprogressList = todos
        todoListView.collectionView?.reloadData()
    }
    
    func showInProgressTodosLoading() {
        // not implemented yet
    }
    
    func hideInProgressTodosLoading() {
        // not implemented yet
    }
    
    func showCompletedTodos(with todos: [Todo]) {
        todoCompletedList = todos
        todoListView.collectionView?.reloadData()
    }
    
    func showCompletedTodosLoading() {
        // not implemented yet
    }
    
    func hideCompletedTodosLoading() {
        // not implemented yet
    }
    
    func showError(error: any Error) {
        print("failed to load with error: \(error.localizedDescription)")
        // not implemented yet
    }
}

// MARK: VIEW DELEGATE
extension TodoListViewController: NavigateToShowAllViewCellDelegate, TodoCreateNewViewCellDelegate, TodoCreateViewToTodoListViewDelegate, TodoDetailsViewToTodoListViewDelegate {
    
    func didUpdateTodo() {
        presenter?.viewDidLoad()
    }
    
    func didDeleteTodo() {
        presenter?.viewDidLoad()
    }
    
    func updateInProgressList() {
        presenter?.interactor?.getInProgressTodos()
    }
    
    func createNewTodo() {
        presenter?.router?.createTodoCreateModule(from: self)
    }
    
    func navigateToShowAll(_ title: String, completed flag: Bool) {
        let list = if flag {
            todoCompletedList
        } else {
            todoInprogressList
        }
        presenter?.router?.createTodoShowAllViewController(from: self, with: title, for: list)
    }
}
