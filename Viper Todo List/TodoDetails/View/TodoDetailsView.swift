//
//  TodoDetailsView.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

class TodoDetailsView: UIView {
    
    private let nameLabel = {
        let view = UILabel()
        view.text = "Название задачи"
        view.textColor = .label
        view.font = .systemFont(ofSize: 22, weight: .semibold)
//        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name = {
        let view = UITextField()
        view.placeholder = "Название задачи"
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel = {
        let view = UILabel()
        view.text = "Описание задачи"
        view.textColor = .label
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTF = {
        let view = UITextField()
        view.placeholder = "Описание задачи"
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .label
//        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let dateCreated = {
        let view = UILabel()
        view.text = "Созданно : 28/08/2024"
        view.textColor = .label
        view.font = .systemFont(ofSize: 26, weight: .thin)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deleteBtn = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.title = "Delete"
        viewConfig.cornerStyle = .medium
        viewConfig.baseBackgroundColor = .systemRed
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let saveBtn = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.title = "Save"
        viewConfig.cornerStyle = .medium
        viewConfig.baseBackgroundColor = .systemBlue
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(nameLabel, name, descriptionLabel, descriptionTF, dateCreated, deleteBtn, saveBtn)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            name.heightAnchor.constraint(equalToConstant: 90),
            name.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionTF.topAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            
            descriptionTF.heightAnchor.constraint(equalToConstant: 350),
            descriptionTF.bottomAnchor.constraint(equalTo: dateCreated.topAnchor, constant: -10),
            descriptionTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            dateCreated.bottomAnchor.constraint(equalTo: deleteBtn.topAnchor, constant: -25),
            dateCreated.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateCreated.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            deleteBtn.heightAnchor.constraint(equalToConstant: 80),
            deleteBtn.widthAnchor.constraint(equalToConstant: 180),
            deleteBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            deleteBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            saveBtn.heightAnchor.constraint(equalToConstant: 80),
            saveBtn.widthAnchor.constraint(equalToConstant: 180),
            saveBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            saveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
        ])
    }
    
    func configure(todo: Todo) {
        name.text = todo.name
        descriptionTF.text = todo.details
        dateCreated.text = "Созданно : \(todo.dateCreated)"
    }
    
}
