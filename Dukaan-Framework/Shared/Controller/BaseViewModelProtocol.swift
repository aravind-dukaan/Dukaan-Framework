//
//  BaseViewModelProtocol.swift
//  Dukaan
//
//  Created by Kartik on 22/02/21.
//

import Foundation
import UIKit
//import AnyErrorKit
//import FLUtilities

protocol BaseViewModelProtocol: AnyObject {
    func showError(message: String)
    func showAlert(message: String)
    func handleError(_ error: AnyError)
    func handleError(_ error: AnyError, actionBlock: @escaping (() -> Void))
    func showLoader()
    func hideLoader()
    var viewController: UIViewController { get }
}

extension UIViewController: BaseViewModelProtocol {
    
    func handleError(_ error: AnyError) {
        hideLoader()
        let title = "OOPS"
        let ok = "OK"
        if error.code == 401 {
            self.showAlert(
                title: title,
                message: "Your session expired, please login again.",
                actionInterfaceList: [
                    ActionInterface(title: ok)
                ],
                handler: { _ in
            })
        } else if error.code == 429 {
            self.showAlert(message: "Please wait for a while and try again.")
        } else {
            self.showError(message: error.message)
        }
    }
    
    func handleError(_ error: AnyError, actionBlock: @escaping (() -> Void)) {
        hideLoader()
        let title = "OOPS"
        let ok = "OK"
        self.showAlert(
            title: title,
            message: error.message,
            actionInterfaceList: [
                ActionInterface(title: ok)
            ],
            handler: { _ in
                actionBlock()
        })
    }
    
    func hideBackButtonTitle() {
        navigationItem.backButtonTitle = ""
    }
    
    func showLoader(message: String? = nil) {
        Loader.showAdded(to: self.view, animated: true)
    }
    
    func showLoader() {
        Loader.showAdded(to: self.view, animated: true)
    }
    
    func hideLoader() {
        Loader.hide(for: self.view, animated: true)
    }
    
    func showError(message: String) {
        self.showErrorAlert(message: message)
    }
    
    func showAlert(message: String) {
        if message.isNotEmpty {
            self.showAlert(title: nil, message: message) {
            }
        }
    }
    
    func showAlert(title: String? = nil, message: String?, actionTitle: String = "OK", actionBlock: @escaping (() -> Void)) {
        let list = [ActionInterface(title: actionTitle)]
        self.showAlert(
            title: title,
            message: message,
            actionInterfaceList: list) { actionInterface in
                if actionInterface.title == actionTitle {
                    actionBlock()
                }
        }
    }

    var viewController: UIViewController {
        return self
    }
}

extension UIView {
    
    func shakeThatAss(completion: (() -> Void)? = nil) {
        let speed = 1.0
        let time = 1.0 * speed - 0.5
        let timeFactor = CGFloat(time / 3)
        let animationDelays = [timeFactor, timeFactor * 1.5, timeFactor * 2]
        let shakeAnimator = UIViewPropertyAnimator(duration: time, dampingRatio: 0.1)

        // left, right, left, center
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 1, y: 0)
        })

        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: -1, y: 0)
        }, delayFactor: animationDelays[0])

        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 1, y: 0)
        }, delayFactor: animationDelays[1])

        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: animationDelays[2])

        shakeAnimator.startAnimation()

        shakeAnimator.addCompletion { _ in
            completion?()
        }
    }
}
