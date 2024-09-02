//
//  TodoLoadingViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import UIKit

class TodoLoadingViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoLoadingViewCell"
    
    // MARK: - View
    let indicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(indicatorView)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW Config

    private func addConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.heightAnchor.constraint(equalToConstant: 90),
            indicatorView.widthAnchor.constraint(equalToConstant: 90),
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ])
    }
    
}
