//
//  TodoErrorViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import UIKit

protocol TodoErrorViewCellDelegate {
    func retry()
}

class TodoErrorViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoErrorViewCell"
    var delegate: TodoErrorViewCellDelegate?
    
    // MARK: - View
    
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.text = "Something went wrong!"
        view.adjustsFontForContentSizeCategory = true
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .systemRed
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let button = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.cornerStyle = .medium
        viewConfig.title = "Retry"
        viewConfig.baseBackgroundColor = .systemBlue
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        button.addTarget(self, action: #selector(retry), for: .touchDown)
        addSubviews(errorLabel, button)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW Config
    
    @objc private func retry() {
        delegate?.retry()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.bottomAnchor.constraint(equalTo: button.topAnchor),
            errorLabel.topAnchor.constraint(equalTo: topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

        ])
    }
    
}
