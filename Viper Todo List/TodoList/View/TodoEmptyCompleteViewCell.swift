//
//  TodoEmptyCompletedViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import UIKit

final class TodoEmptyCompleteViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoEmptyCompleteViewCell"
    
    private let name: UILabel = {
        let view = UILabel()
        view.text = "Empty view"
        view.adjustsFontForContentSizeCategory = true
        view.font = .systemFont(ofSize: 20, weight: .thin)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let details = {
       let view = UILabel()
       view.text = "Your completed Todos will show here"
       view.font = .systemFont(ofSize: 20, weight: .thin)
       view.textColor = .label
        view.numberOfLines = 1
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let horizontalDivider = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalDivider = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let dateCreated = {
       let view = UILabel()
       view.text = "Дата создания : 25/08/2024"
       view.font = .systemFont(ofSize: 18, weight: .thin)
       view.textColor = .label
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    
    private let dateCompleted = {
       let view = UILabel()
       view.text = "Дата выполнения: 02/09/2024"
       view.font = .systemFont(ofSize: 18, weight: .thin)
       view.textColor = .label
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    private let markAsUncompleted = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(systemName: "checkmark.circle.fill")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(verticalDivider, name, dateCreated, dateCompleted, horizontalDivider, details, markAsUncompleted)
        addConstraints()
        contentView.alpha = 0.3
        contentView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            horizontalDivider.heightAnchor.constraint(equalToConstant: 1),
            verticalDivider.widthAnchor.constraint(equalToConstant: 10),
            
            verticalDivider.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalDivider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            details.bottomAnchor.constraint(equalTo: horizontalDivider.topAnchor, constant: -25),
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            details.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            horizontalDivider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            horizontalDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            horizontalDivider.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            dateCreated.topAnchor.constraint(equalTo: horizontalDivider.bottomAnchor, constant: 25),
            dateCreated.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateCreated.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            dateCompleted.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            dateCompleted.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateCompleted.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -5),
            
            // Match markAsUncompleted center with center-gap of dateCreated and dateCompleted
            markAsUncompleted.heightAnchor.constraint(equalToConstant: 30),
            markAsUncompleted.widthAnchor.constraint(equalToConstant: 30),
            markAsUncompleted.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: (contentView.bounds.height/4)+5),
            markAsUncompleted.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor, constant: -10),
            
        ])
    }
}
