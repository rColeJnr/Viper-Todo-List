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

class TodoListViewController: UIViewController, NavigateToShowAllViewCellDelegate {

    private let todoListView = TodoListView()
    private var detailsVC: TodoDetailsViewController?
    var router: TodoListRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView(todoListView)
        
        detailsVC = router?.createTodoDetailsViewController()
        
        todoListView.collectionView?.delegate = self
        todoListView.collectionView?.dataSource = self
    
    }
    
    func navigateToShowAll(_ title: String) {
        
        guard let showAllVC = router?.createTodoShowAllViewController(title) else {
            fatalError("Failed to create Show all controller")
        }
        
        navigationController?.pushViewController( showAllVC, animated: true)
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
            return dummyData.count
        case .completed:
            return dummyData.count
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
            cell.configure(todo: dummyData[indexPath.row])
            return cell
            
        case .uncompleted:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodoUncompleteViewCell.cellIdentifier,
                for: indexPath
            ) as? TodoUncompleteViewCell else {
                fatalError()
            }
            cell.configure(todo: dummyData[indexPath.row])
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
        let todo = dummyData[indexPath.row]
        guard let detailsVC = self.detailsVC else {
            fatalError("DetailsVC is null")
        }
        detailsVC.todo = todo
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
