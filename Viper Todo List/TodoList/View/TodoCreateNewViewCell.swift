//
//  TodoAddNewViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

class TodoCreateNewViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoCreateNewViewCell"
    
    private let button = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.cornerStyle = .medium
        viewConfig.title = "+ Create New"
        viewConfig.baseBackgroundColor = .systemBlue
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground

        contentView.addSubview(button)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

           
        ])
    }
    
}
