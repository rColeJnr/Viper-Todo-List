//
//  TodoUnoompletedRowViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

class TodoUncompleteRowViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoUncompleteRowViewCell"
    
    private let title: UILabel = {
        let view = UILabel()
        view.text = "In Progress"
        view.adjustsFontForContentSizeCategory = true
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let showAll = {
       let view = UILabel()
       view.text = "Show all"
       view.font = .systemFont(ofSize: 18, weight: .medium)
       view.textColor = .blue
        view.isUserInteractionEnabled = true
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
      
    @objc private func statusValueDidChange(_ sender: UISwitch) {
        print("Value change")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground

        contentView.addSubviews(title, showAll)
//        statusSwitch.addTarget(self, action: #selector(statusValueDidChange(_ :)), for: .valueChanged)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            showAll.topAnchor.constraint(equalTo: topAnchor),
            showAll.bottomAnchor.constraint(equalTo: bottomAnchor),
            showAll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           
        ])
    }
    

//    /// Bind Todo item to UI
//    func configure(todo: Todo) {
//        name.text = todo.name
//        details.text = todo.details
//        dateCreated.text = todo.dateCreated
//        statusSwitch.isOn = todo.status
//    }
}
