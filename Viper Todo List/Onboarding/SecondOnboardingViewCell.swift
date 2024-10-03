//
//  SecondOnboardingViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 04/09/24.
//

import UIKit

protocol SecondOnboardingViewCellDelegate {
    func navigateToHomeController()
}

final class SecondOnboardingViewCell: UICollectionViewCell {
    static let cellIdentifier = "SecondOnboardingViewCell"
    
    var delegate: SecondOnboardingViewCellDelegate?
    
    let image = {
        let view = UIImageView()
        view.image = .onboardingSecond
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let title = {
        let view = UILabel()
        view.text = "Create your first TODO"
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.textColor = .white
        view.textAlignment = .left
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionTV = {
        let view = UILabel()
        view.text = "Create your first task, write down your tasks and goals, set a deadline, and stick to your goals"
        view.font = .systemFont(ofSize: 18, weight: .thin)
        view.textColor = .white
        view.textAlignment = .left
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageIndicator = {
        let view = UIImageView()
        view.image = UIImage( named: "onboarding_second_indicator")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startBtn = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.title = "Start"
        viewConfig.baseBackgroundColor = .systemBlue
        viewConfig.baseForegroundColor = .white
        let view = UIButton(configuration: viewConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    let policyLabel = {
        let view = UILabel()
        view.text = "Terms of use | Privacy policy"
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - onClickListeners
    @objc private func onStartBtnClick(_ sender: Any) {
        delegate?.navigateToHomeController()
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemCyan
        startBtn.addTarget(self, action: #selector(onStartBtnClick(_ :)), for: .touchDown)
        contentView.addSubviews(image, title, descriptionTV, pageIndicator, startBtn, policyLabel)
        addConstraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            title.heightAnchor.constraint(equalToConstant: 60),
            title.bottomAnchor.constraint(equalTo: descriptionTV.topAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionTV.heightAnchor.constraint(equalToConstant: 90),
            descriptionTV.bottomAnchor.constraint(equalTo: pageIndicator.topAnchor, constant: -30),
            descriptionTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            pageIndicator.heightAnchor.constraint(equalToConstant: 15),
            pageIndicator.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -20),
            pageIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            startBtn.heightAnchor.constraint(equalToConstant: 60),
            startBtn.bottomAnchor.constraint(equalTo: policyLabel.topAnchor, constant: -10),
            startBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            startBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            policyLabel.heightAnchor.constraint(equalToConstant: 20),
            policyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            policyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            policyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}
