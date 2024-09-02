//
//  TodoEmptyInProgressViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import UIKit

class todoEmptyInProgreessViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "todoEmptyInProgreessViewCell"
    
    private let name = {
       let view = UILabel()
       view.text = "Empty view"
       view.font = .systemFont(ofSize: 25, weight: .thin)
       view.textColor = .label
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    private let dateCreated = {
       let view = UILabel()
       view.text = "Дата создания : 25/08/2024"
       view.font = .systemFont(ofSize: 20, weight: .thin)
       view.textColor = .label
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let horizontalDivider = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalDivider = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailsLabel = {
       let view = UILabel()
       view.text = "Описание :"
       view.font = .systemFont(ofSize: 18, weight: .thin)
       view.textColor = .label
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let details = {
       let view = UILabel()
       view.text = "Tap \"+ Create New\" to a create a new todo..."
       view.font = .systemFont(ofSize: 22, weight: .thin)
       view.textColor = .label
        view.numberOfLines = 2
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    private let markAsCompleted = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(systemName: "checkmark.circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.alpha = 0.5
        contentView.addSubviews(name, dateCreated, horizontalDivider, verticalDivider, detailsLabel, details, markAsCompleted)
        contentView.layer.cornerRadius = 15
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 30),
            dateCreated.heightAnchor.constraint(equalToConstant: 30),
            markAsCompleted.heightAnchor.constraint(equalToConstant: 30),
            horizontalDivider.heightAnchor.constraint(equalToConstant: 1),
            verticalDivider.widthAnchor.constraint(equalToConstant: 10),
            
            verticalDivider.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: markAsCompleted.leadingAnchor, constant: -5),
            
            dateCreated.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            dateCreated.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateCreated.trailingAnchor.constraint(equalTo: markAsCompleted.leadingAnchor, constant: -5),
            
            horizontalDivider.topAnchor.constraint(equalTo: dateCreated.bottomAnchor, constant: 10),
            horizontalDivider.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: -10),
            horizontalDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            horizontalDivider.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            detailsLabel.bottomAnchor.constraint(equalTo: details.topAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            detailsLabel.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            details.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            details.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            // Match markAsUncompleted center with center-gap of dateCreated and dateCompleted
            markAsCompleted.heightAnchor.constraint(equalToConstant: 30),
            markAsCompleted.widthAnchor.constraint(equalToConstant: 30),
            markAsCompleted.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -(contentView.bounds.height/4)-5),
            markAsCompleted.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -10),
        ])
    }
}
