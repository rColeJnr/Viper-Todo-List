//
//  TodoCreateView.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import UIKit

protocol TodoCreateViewDelegate {
    func createNewTodo(for todo: TodoModel)
}

class TodoCreateView: UIView {
    
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
    
    internal let name = {
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
    
    internal let descriptionTF = {
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
    
    internal let dateCreated = {
        let view = UILabel()
        view.text = "Созданно : "
        view.textColor = .label
        view.font = .systemFont(ofSize: 26, weight: .thin)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let datePickerView = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .dateAndTime
        view.minimumDate = .now
        view.preferredDatePickerStyle = .compact
        return view
    }()
    
    internal let createBtn = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.title = "+ Create"
        viewConfig.cornerStyle = .medium
        viewConfig.baseBackgroundColor = .systemBlue
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let priorityBtn = {
        var viewConfig = UIButton.Configuration.plain()
        viewConfig.title = "Mark as priority"
        viewConfig.cornerStyle = .medium
        viewConfig.baseForegroundColor = .systemBlue
        viewConfig.image = UIImage(systemName: "checkmark.circle")
        viewConfig.imagePlacement = .trailing
        viewConfig.imagePadding = 10
        let view = UIButton(configuration: viewConfig)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let errorView = {
        let view = UILabel()
        view.text = "A todo must have a name and description"
        view.textColor = .red
        view.isHidden = true
        view.font = .systemFont(ofSize: 22, weight: .medium)
        view.textAlignment = .center
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        createBtn.addTarget(self, action: #selector(createBtnTarget), for: .touchUpInside)
        priorityBtn.addTarget(self, action: #selector(priorityBtnTarget), for: .touchUpInside)
        addSubviews(errorView, nameLabel, name, descriptionLabel, descriptionTF, datePickerView, dateCreated, priorityBtn, createBtn)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW CONFIG
    
    var delegate: TodoCreateViewDelegate?
    
    internal func cannotCreateTodo() -> Bool {
        return name.text.isEmpty || descriptionTF.text.isEmpty
    }
    
    @objc private func createBtnTarget(_ sender: UIButton) {
        if cannotCreateTodo(){
            self.errorView.isHidden = false
            return
        }
        
        let todo = TodoModel(name: name.text, details: descriptionTF.text, completed: false, priority: isPriority, dateCreated: datePickerView.date)
        self.delegate?.createNewTodo(for: todo)
    }
    
    private var isPriority: Bool = false
    @objc private func priorityBtnTarget(_ sender: UIButton) {
        isPriority = true
        priorityBtn.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
        priorityBtn.isUserInteractionEnabled = false
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            errorView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            errorView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        
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
            
            descriptionTF.heightAnchor.constraint(equalToConstant: 240),
            descriptionTF.bottomAnchor.constraint(equalTo: datePickerView.topAnchor, constant: -10),
            descriptionTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            dateCreated.bottomAnchor.constraint(equalTo: datePickerView.bottomAnchor),
            dateCreated.topAnchor.constraint(equalTo: datePickerView.topAnchor),
            dateCreated.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateCreated.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.37),
            
            datePickerView.bottomAnchor.constraint(equalTo: priorityBtn.topAnchor, constant: -25),
            datePickerView.leadingAnchor.constraint(equalTo: dateCreated.trailingAnchor, constant: 10),
          
            priorityBtn.heightAnchor.constraint(equalToConstant: 40),
            priorityBtn.bottomAnchor.constraint(equalTo: createBtn.topAnchor, constant: -5),
            priorityBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priorityBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            createBtn.heightAnchor.constraint(equalToConstant: 80),
            createBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            createBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            createBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
 
}

