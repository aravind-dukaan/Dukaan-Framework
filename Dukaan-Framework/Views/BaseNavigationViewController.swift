//
//  BaseNavigationViewController.swift
//  Dukaan
//
//  Created by Srinivas on 07/12/21.
//

import Foundation
import UIKit


class BaseNavigationViewController: UINavigationController {
    /// Indicates if a UIViewController is currently being pushed onto this navigation controller
    private var duringPushAnimation = false

        override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButtonTitle()
        self.delegate = self // to track when a view controller is being pushed
        self.interactivePopGestureRecognizer?.delegate = self // for swipe the pop gesture recogniser
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
  
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (navigationController as? BaseNavigationViewController)?.duringPushAnimation = false
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {

     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture in three situations:
        // 1) the view controller doesn't support being popped or doesn't want to be popped right now
        if let viewController = visibleViewController as? BaseViewController, viewController.preventInteractivePopGesture() {
            return false
        }

        // 2) when there is only one view controller on the stack
        // 3) when the pop animation is in progress
        return viewControllers.count > 1 && self.duringPushAnimation == false
    }
}
