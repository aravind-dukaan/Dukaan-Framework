//
//  ModalPresentationController.swift
//  Dukaan
//
//  Created by Raja Earla on 16/03/21.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    
    private let dimmingView = UIView()
    private let roundingView = UIView()
    
    // MARK: -
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapShroud))
        tapGesture.cancelsTouchesInView = false
        dimmingView.addGestureRecognizer(tapGesture)
        
        roundingView.translatesAutoresizingMaskIntoConstraints = false
        roundingView.backgroundColor = .white
        roundingView.clipsToBounds = true
        roundingView.roundTop(radius: 16)
//        roundingView.layer.cornerCurve = .continuous
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // Double-checking this here in case nested modals steal our presented
        // view controller's view, since that breaks all of our constraints.
        installPresentedViewInCustomViews()
    }
    
    override var presentedView: UIView? {
        return roundingView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        installCustomViews()
        installPresentedViewInCustomViews()
        animateDimmingViewIn()
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        // Remove views if transition was aborted.
        //
        // If transition completed normally, nothing to do.
        if !completed {
            removeCustomViews()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        animateDimmingViewOut()
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // Remove views if transition completed.
        //
        // If transition was aborted, nothing to do.
        if completed {
            removeCustomViews()
        }
    }
    
    // MARK: -
    
    @objc private func onTapShroud(_ sender: UIControl) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    private func installCustomViews() {
        guard let containerView = containerView else {
            assertionFailure("Can't set up custom views without a container view. Transition must not be started yet.")
            return
        }
        
        containerView.addSubview(dimmingView)
        containerView.addSubview(roundingView)
        
        NSLayoutConstraint.activate([
            // Block the content.
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: dimmingView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: dimmingView.trailingAnchor),
            
            // Fit the card to the bottom of the screen within the readable width.
            roundingView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: containerView.readableContentGuide.topAnchor, multiplier: 1),
            roundingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: roundingView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: roundingView.trailingAnchor), {
                // Weakly squeeze the content toward the bottom. This functions
                // just like the `verticalFittingPriority` in
                // `UIView.systemLayoutSizeFitting` to get the card to try
                // and fit its content while meeting the other constrainnts.
                let minimizingHeight = roundingView.heightAnchor.constraint(equalToConstant: 0)
                minimizingHeight.priority = .fittingSizeLevel
                return minimizingHeight
            }()
        ])
    }
    
    private func installPresentedViewInCustomViews() {
        guard !presentedViewController.view.isDescendant(of: roundingView) else { return }
        
        presentedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        roundingView.addSubview(presentedViewController.view)

        NSLayoutConstraint.activate([
            presentedViewController.view.topAnchor.constraint(equalTo: roundingView.topAnchor),
            presentedViewController.view.leadingAnchor.constraint(equalTo: roundingView.leadingAnchor),
            roundingView.bottomAnchor.constraint(equalTo: presentedViewController.view.bottomAnchor),
            roundingView.trailingAnchor.constraint(equalTo: presentedViewController.view.trailingAnchor)
        ])
    }
    
    private func animateDimmingViewIn() {
        dimmingView.alpha = 0
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    private func animateDimmingViewOut() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    private func removeCustomViews() {
        roundingView.removeFromSuperview()
        dimmingView.removeFromSuperview()
    }
    
}

final class ModalPresenting: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
