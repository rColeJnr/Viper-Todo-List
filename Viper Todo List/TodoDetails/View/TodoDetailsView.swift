//
//  TodoDetailsView.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import UIKit

protocol TodoDetailsViewDelegate {
    func updateTodo(todo: Todo)
    func deleteTodo(todo: Todo)
}

class TodoDetailsView: UIView {
    
    // MARK: - VIEWS
    private let nameLabel = {
        let view = UILabel()
        view.text = "Название задачи"
        view.textColor = .label
        view.font = .systemFont(ofSize: 22, weight: .medium)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name = {
        let view = UITextView()
        view.isEditable = true
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
        view.font = .systemFont(ofSize: 22, weight: .medium)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTF = {
        let view = UITextView()
        view.isEditable = true
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .label
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let markAsComplete = {
        var viewConfig = UIButton.Configuration.plain()
        viewConfig.baseForegroundColor = .systemBlue
        viewConfig.imagePlacement = .trailing
        viewConfig.imagePadding = 25
        let view = UIButton(configuration: viewConfig)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateCreated = {
        let view = UILabel()
        view.text = "Созданно :"
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
        view.isUserInteractionEnabled = true
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
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorView = {
        let view = UILabel()
        view.text = "No changes made"
        view.textColor = .red
        view.font = .systemFont(ofSize: 22, weight: .medium)
        view.textAlignment = .center
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        markAsComplete.addTarget(self, action: #selector(onMarkAsComplete), for: .touchDown)
        saveBtn.addTarget(self, action: #selector(onSaveBtn), for: .touchDown)
        deleteBtn.addTarget(self, action: #selector(onDeleteBtn), for: .touchDown)
        addSubviews(errorView, nameLabel, name, descriptionLabel, descriptionTF, markAsComplete, dateCreated, deleteBtn, saveBtn)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW CONFIG
    
    var delegate: TodoDetailsViewDelegate?
    
    @objc private func onMarkAsComplete(_ sender: UIButton) {
        self.isCompleted = !self.isCompleted
        if isCompleted {
            markAsComplete.configuration?.title = "Mark as In Progress"
            markAsComplete.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            markAsComplete.configuration?.title = "Mark as Completed"
            markAsComplete.configuration?.image = UIImage(systemName: "checkmark.circle")
        }
    }
    
    @objc private func onSaveBtn(_ sender: UIButton) {
        if name.text != todo.name || descriptionTF.text != todo.details || isCompleted != todo.completed {
            todo.name = name.text
            todo.details = descriptionTF.text
            todo.completed = isCompleted
            if isCompleted {
                todo.dateCompleted = Date.now
            } else {
                todo.dateCompleted = nil
            }
            delegate?.updateTodo(todo: todo)
        } else {
            errorView.isHidden = false
        }
    }
    
    @objc private func onDeleteBtn(_ sender: UIButton) {
        delegate?.deleteTodo(todo: todo)
    }
    
    private var isCompleted: Bool!
    private var todo: Todo!
    /// Bind UI with data
    func configure(with todo: Todo) {
        self.todo = todo
        self.isCompleted = todo.completed
        name.text = todo.name
        descriptionTF.text = todo.details
        if isCompleted {
            markAsComplete.configuration?.title = "Mark as In Progress"
            markAsComplete.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            markAsComplete.configuration?.title = "Mark as Completed"
            markAsComplete.configuration?.image = UIImage(systemName: "checkmark.circle")
        }
        dateCreated.text = "Созданно : \(VtlDateFormatter.shared.dateFormatter(from: todo.dateCreated))"
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
            
            descriptionTF.heightAnchor.constraint(equalToConstant: 280),
            descriptionTF.bottomAnchor.constraint(equalTo: markAsComplete.topAnchor, constant: -10),
            descriptionTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            markAsComplete.heightAnchor.constraint(equalToConstant: 70),
            markAsComplete.bottomAnchor.constraint(equalTo: dateCreated.topAnchor, constant: -10),
            markAsComplete.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            markAsComplete.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
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
}
