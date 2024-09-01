//
//  TodoShowAllTableView.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoShowAllViewDelegate: AnyObject {
    func didSelectTodo(with todo: Todo)
}

class TodoShowAllView: UIView {
    
    public weak var delegate: TodoShowAllViewDelegate?
    var todoList: [Todo] = []
    
    private var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(todoInProgreessViewCell.self,
                                forCellWithReuseIdentifier: todoInProgreessViewCell.cellIdentifier)
        return collectionView
    }()
    
    private let indicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(indicatorView, collectionView)
        indicatorView.startAnimating()
        addConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.heightAnchor.constraint(equalToConstant: 100),
            indicatorView.widthAnchor.constraint(equalToConstant: 100),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension TodoShowAllView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todoInProgreessViewCell.cellIdentifier, for: indexPath) as? todoInProgreessViewCell else {
            fatalError("Failed to create show all view cell")
        }
        cell.configure(todo: todoList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width: CGFloat
        if UIDevice.isiPhone {
            width = bounds.width-30
        } else {
            width = (bounds.width-50)/4
        }
        
        return CGSize(width: width, height: width/2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        delegate?.didSelectTodo(with: todo)
    }
}
