//
//  VtlExtenstions.swift
//  Viper Todo List
//
//  Created by rColeJnr on 27/08/24.
//

import UIKit

extension UIViewController {
    /// Add main view to viewController and constraint
    /// - Parameter view: UIView
    func setupView(_ view: UIView) {
        self.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension UIView {
    /// Add multiple subviews
    /// - Parameter views: Variadic views
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

extension UIDevice {
    /// Check if current device is iPhone idiom
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
