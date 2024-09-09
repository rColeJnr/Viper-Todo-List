//
//  TodoLIstCollectionView.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

final class TodoListView: UIView {
    
    // MARK: - Views
    
    public var collectionView: UICollectionView?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CreateCollectionView
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        // MARK: InProgressRow
        collectionView.register(TodoInProgressRowViewCell.self, forCellWithReuseIdentifier: TodoInProgressRowViewCell.cellIdentifier)
        
        // MARK: InProgressView
        collectionView.register(todoInProgressViewCell.self, forCellWithReuseIdentifier: todoInProgressViewCell.cellIdentifier)
        
        // MARK: CompleteView
        collectionView.register(TodoCompleteViewCell.self, forCellWithReuseIdentifier: TodoCompleteViewCell.cellIdentifier)
        
        // MARK: CompleteRow
        collectionView.register(TodoCompleteRowViewCell.self, forCellWithReuseIdentifier: TodoCompleteRowViewCell.cellIdentifier)
        
        // MARK: CreateNew
        collectionView.register(TodoCreateNewViewCell.self, forCellWithReuseIdentifier: TodoCreateNewViewCell.cellIdentifier)
        
        // MARK: EmptyCompleteView
        collectionView.register(TodoEmptyCompleteViewCell.self, forCellWithReuseIdentifier: TodoEmptyCompleteViewCell.cellIdentifier)
        
        // MARK: EmptyInProgressView
        collectionView.register(todoEmptyInProgreessViewCell.self, forCellWithReuseIdentifier: todoEmptyInProgreessViewCell.cellIdentifier)
        
        // MARK: LoadingView
        collectionView.register(TodoLoadingViewCell.self, forCellWithReuseIdentifier: TodoLoadingViewCell.cellIdentifier)
        
        // MARK: ErrorView
        collectionView.register(TodoErrorViewCell.self, forCellWithReuseIdentifier: TodoErrorViewCell.cellIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = TodoListSectionType.allCases
        switch sectionTypes[sectionIndex] {
        case .inProgressRow:
            return createInProgressRowSection()
        case .inProgress:
            return createInProgressSection()
        case .completedRow:
            return createCompletedRowSection()
        case .completed:
            return createCompletedSection()
        case .createNew:
            return createAddNewSection()
        case .EmptyInProgress:
            return createEmptyInProgressSection()
        case .EmptyCompleted:
            return createEmptyCompletedSection()
        case .LoadingView:
            return createLoadingSection()
        case .ErrorView:
            return createErrorSection()
        }
        
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TodoListView {
    
    func createInProgressSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )
       
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.30)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
        
    func createCompletedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.32)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createCompletedRowSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
        
    func createInProgressRowSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createAddNewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    func createEmptyCompletedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.32)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createEmptyInProgressSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )
       
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.30)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createLoadingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    func createErrorSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(140)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
}
