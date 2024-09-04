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
    private var todoInprogressList: [Todo] = []
    private var todoCompletedList: [Todo] = []
    private var errorView: [Int] = []
    private var loadingView: [Int] = [1]
    private var emptyInProgress: [Int] = [1]
    private var emptyCompleted: [Int] = [1]
    
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
            
        case .LoadingView:
            return loadingView.count
            
        case .ErrorView:
            return errorView.count
            
        case .EmptyInProgress:
            return emptyInProgress.count
            
        case .EmptyCompleted:
            return emptyCompleted.count
            
        default:
            return 1
        }
    }
    
    // MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = TodoListSectionType.allCases[indexPath.section]
        switch sectionType {
        //MARK: COMPLETED
        case .completed:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCompleteViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCompleteViewCell else {
                fatalError()
            }
            cell.configure(todo: todoCompletedList[indexPath.row])
            return cell
        // MARK: INPROGRESS
        case .inProgress:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: todoInProgressViewCell.cellIdentifier,
                for: indexPath
            ) as? todoInProgressViewCell else {
                fatalError()
            }
            cell.configure(todo: todoInprogressList[indexPath.row])
            return cell
        // MARK: COMPLETEDROW
        case .completedRow:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCompleteRowViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCompleteRowViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        // MARK: INPROGRESSROW
        case .inProgressRow:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoInProgressRowViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoInProgressRowViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        // MARK: CREATENEW
        case .createNew:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoCreateNewViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoCreateNewViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        // MARK: EMPTYINPROGRESS
        case .EmptyInProgress:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: todoEmptyInProgreessViewCell.cellIdentifier,
                for: indexPath
            ) as? todoEmptyInProgreessViewCell else {
                fatalError()
            }
            return cell
        // MARK: EMPTYCOMPLETED
        case .EmptyCompleted:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoEmptyCompleteViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoEmptyCompleteViewCell else {
                fatalError()
            }
            return cell
        // MARK: LOADINGVIEW
        case .LoadingView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoLoadingViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoLoadingViewCell else {
                fatalError()
            }
            cell.indicatorView.startAnimating()
            return cell
        // MARK: ERRORVIEW
        case .ErrorView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoErrorViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoErrorViewCell else {
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
                withReuseIdentifier: todoInProgressViewCell.cellIdentifier,
                for: indexPath
            ) is todoInProgressViewCell else {
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
        errorView = []
        todoInprogressList = todos
        if todoInprogressList.isEmpty {
            emptyInProgress = [1]
        } else {
            emptyInProgress = []
        }
        todoListView.collectionView?.reloadData()
    }
    
    func showInProgressTodosLoading() {
        loadingView = [1]
        todoListView.collectionView?.reloadData()
    }
    
    func hideInProgressTodosLoading() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
            
            OperationQueue.main.addOperation {
                self.loadingView = []
                self.todoListView.collectionView?.reloadData()
            }
        })
    }
    
    func showCompletedTodos(with todos: [Todo]) {
        errorView = []
        todoCompletedList = todos
        if todoCompletedList.isEmpty {
            emptyCompleted = [1]
        } else {
            emptyCompleted = []
        }
        todoListView.collectionView?.reloadData()
    }
    
    func showCompletedTodosLoading() {
        loadingView = [1]
        todoListView.collectionView?.reloadData()
    }
    
    func hideCompletedTodosLoading() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
            
            OperationQueue.main.addOperation {
                self.loadingView = []
                self.todoListView.collectionView?.reloadData()
            }
        })
    }
    
    func showError(error: any Error) {
        print("failed to load with error: \(error.localizedDescription)")
        errorView = [1]
        todoListView.collectionView?.reloadData()
    }
}

// MARK: VIEW DELEGATE
extension TodoListViewController: NavigateToShowAllViewCellDelegate, TodoCreateNewViewCellDelegate, TodoCreateViewToTodoListViewDelegate, TodoDetailsViewToTodoListViewDelegate, TodoErrorViewCellDelegate {
    
    func retry() {
        presenter?.viewDidLoad()
    }
    
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
