//
//  TodoUnoompletedRowViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

class TodoInProgressRowViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "TodoUncompleteRowViewCell"
    public var delegate: TodoInProgressRowViewCellDelegate?
    
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
    
    // UIButton fits better than UIImageView
    private let sortBtn = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "line.3.horizontal.decrease")
        config.imagePlacement = .leading
        config.imagePadding = 4
        let view = UIButton(configuration: config)
        view.tintColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
      
    // MARK: - TARGETS
    @objc private func navigateToShowAll(_ sender: Any) {
        delegate?.navigateToShowAll("In Progress", completed: false)
    }
    
    @objc private func sortingTarget(_ sender: UIButton) {
        
    }
    
    private func sortByOption(sortBy option: String) {
        delegate?.inProgressSortedBy(option)
    }
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(title, sortBtn, showAll)
        showAll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToShowAll(_ :))))
        let sortingOptions = SortingOptions.allCases
        let actions: [UIAction] = sortingOptions.map {
            let action = UIAction(title: $0.rawValue, handler:{ option in
                self.sortBtn.configuration?.title = option.title
                self.sortByOption(sortBy: option.title)
               
            })
            return action
        }
        let menu = UIMenu(children: actions)
        sortBtn.menu = menu
        sortBtn.showsMenuAsPrimaryAction = true
        
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

            sortBtn.topAnchor.constraint(equalTo: topAnchor),
            sortBtn.trailingAnchor.constraint(equalTo: showAll.leadingAnchor, constant: -10),
            sortBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            showAll.topAnchor.constraint(equalTo: topAnchor),
            showAll.bottomAnchor.constraint(equalTo: bottomAnchor),
            showAll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           
        ])
    }
    
}
