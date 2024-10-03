//
//  OnboardingViewController.swift
//  Viper Todo List
//
//  Created by rColeJnr on 03/09/24.
//

import UIKit

protocol NavigateToSecondOnboardingScreenDelegate: AnyObject {
    func navigateToSecondScreen()
}

final class OnboardingViewController: UIViewController {
    
    private let onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setupView(onboardingView)
        onboardingView.collectionView?.delegate = self
        onboardingView.collectionView?.dataSource = self
        onboardingView.collectionView?.backgroundColor = .systemCyan
        
    }
}

extension OnboardingViewController: FirstOnboardingViewCellDelegate, SecondOnboardingViewCellDelegate {
    func showSecondOnboardingView() {
        let indexPath = IndexPath(item: 0, section: 1)
        self.onboardingView.collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    func navigateToHomeController() {
        VtlUserDefaults.shared.setNotIsNewUSer()
        let controller = TodoListRouter().createModule()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return OnboardingScreens.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = OnboardingScreens.allCases[indexPath.section]
        
        switch sectionType {
        case .firstOnboardingScreen:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FirstOnboardingViewCell.cellIdentifier,
                for: indexPath
            ) as? FirstOnboardingViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        case .secondOnboardingScreen:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SecondOnboardingViewCell.cellIdentifier,
                for: indexPath
            ) as? SecondOnboardingViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        }
    }
}
