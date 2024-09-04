//
//  TodoNavigationControllerMock.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import UIKit

class TodoNavigationControllerMock: UINavigationController {
  var lastPushedViewController: UIViewController?

  override func pushViewController(
    _ viewController: UIViewController,
    animated: Bool) {

      lastPushedViewController = viewController
      super.pushViewController(viewController,
                               animated: animated)
    }

  var popViewControllerCount = 0

  override func popViewController(animated: Bool) -> UIViewController? {
    popViewControllerCount += 1
    return super.popViewController(animated: animated)
  }

}
