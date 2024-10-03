//
//  OnboardingViewCell.swift
//  Viper Todo List
//
//  Created by rColeJnr on 03/09/24.
//

import UIKit

protocol FirstOnboardingViewCellDelegate {
    func showSecondOnboardingView()
}

final class FirstOnboardingViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "FirstOnboardingViewCell"
    var delegate: FirstOnboardingViewCellDelegate?
    
    // MARK: - VIEWS
    let image = {
        let view = UIImageView()
        view.image = .onboardingFirst
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let title = {
        let view = UILabel()
        view.text = "Welcome to Viper Todo LIST"
        view.font = .systemFont(ofSize: 26, weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionTV = {
        let view = UILabel()
        view.text = "ThIS application will help you Monitor, Create, edit and delete your tasks"
        view.font = .systemFont(ofSize: 18, weight: .thin)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = .max
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageIndicator = {
        let view = UIImageView()
        view.image = UIImage( named: "onboarding_first_indicator")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nextBtn = {
        var viewConfig = UIButton.Configuration.bordered()
        viewConfig.title = "Next"
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
    @objc private func onNextBtnClick(_ sender: Any) {
        delegate?.showSecondOnboardingView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemCyan
        nextBtn.addTarget(self, action: #selector(onNextBtnClick(_ :)), for: .touchDown)
        contentView.addSubviews(image, title, descriptionTV, pageIndicator, nextBtn, policyLabel)
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
            pageIndicator.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -20),
            pageIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nextBtn.heightAnchor.constraint(equalToConstant: 60),
            nextBtn.bottomAnchor.constraint(equalTo: policyLabel.topAnchor, constant: -10),
            nextBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nextBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            policyLabel.heightAnchor.constraint(equalToConstant: 20),
            policyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            policyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            policyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}
