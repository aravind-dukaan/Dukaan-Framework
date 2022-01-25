//
//  Snackbar.swift
//  Dukaan
//
//  Created by Kartik on 23/03/21.
//

import Foundation
import UIKit
import Darwin

enum SnackbarType {
    case `default`
    case success
    case critical
    case neutral
}

class Snackbar {
    static var snackbar: TTGSnackbar?
    
    class func showSnackBar(with message: String, type: SnackbarType, _ bottomMargin: CGFloat? = nil, _ dismissBlock:  ((_ snackbar: TTGSnackbar) -> Void)? = nil) {
        let impactGenerator = UINotificationFeedbackGenerator()
        var feedbackType = UINotificationFeedbackGenerator.FeedbackType.success
        
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        snackbar.messageTextFont = .body3
        snackbar.messageLabel.textAlignment = .center
        snackbar.contentInset = .zero
        snackbar.messageTextColor = .white
        snackbar.dismissBlock = dismissBlock
        if let btmMargin = bottomMargin {
            snackbar.bottomMargin = btmMargin
        }
        switch type {
        case .default:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .success
        case .success:
            snackbar.backgroundColor = .green
            feedbackType = .success
        case .critical:
            snackbar.backgroundColor = .textCritical
            feedbackType = .error
        case .neutral:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .warning
        }
        impactGenerator.notificationOccurred(feedbackType)
        self.snackbar?.removeFromSuperview()
        self.snackbar = snackbar
        snackbar.show()
    }
    
    class func showSnackBar(with message: String, type: SnackbarType, _ bottomMargin: CGFloat? = nil) {
        Snackbar.showSnackBar(with: message, type: type, bottomMargin, nil)
    }
    
    class func showSnackBar(with message: String, actionText: String, type: SnackbarType, completion: @escaping (_ snackbar: TTGSnackbar) -> Void) {
        let impactGenerator = UINotificationFeedbackGenerator()
        var feedbackType = UINotificationFeedbackGenerator.FeedbackType.success
        
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        snackbar.iconImageViewWidth = 0
        snackbar.messageTextFont = .heading5
//        snackbar.messageLabel.textAlignment = .left
        snackbar.contentInset = .zero
        snackbar.messageTextColor = .white
        snackbar.actionText = actionText
        snackbar.actionTextFont = UIConfig.fontProvider.font(ofSize: 14, weight: .medium)
        snackbar.actionTextColor = .white
        snackbar.separateViewBackgroundColor = .clear
        snackbar.actionBlock = completion
        snackbar.messageContentInset = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        
        switch type {
        case .default:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .success
        case .success:
            snackbar.backgroundColor = .green
            feedbackType = .success
        case .critical:
            snackbar.backgroundColor = .textCritical
            feedbackType = .error
        case .neutral:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .warning
        }
        impactGenerator.notificationOccurred(feedbackType)
        self.snackbar?.removeFromSuperview()
        self.snackbar = snackbar
        snackbar.show()
    }
    
    @discardableResult
    class func showSnackBarForever(with message: String, type: SnackbarType, _ bottomMargin: CGFloat? = nil, _ dismissBlock:  ((_ snackbar: TTGSnackbar) -> Void)? = nil) -> TTGSnackbar {
        let impactGenerator = UINotificationFeedbackGenerator()
        var feedbackType = UINotificationFeedbackGenerator.FeedbackType.success
        
        let snackbar = TTGSnackbar(message: message, duration: .forever)
        snackbar.messageTextFont = .heading5
        snackbar.messageLabel.textAlignment = .center
        snackbar.contentInset = .zero
        snackbar.messageTextColor = .white
        snackbar.dismissBlock = dismissBlock
        if let btmMargin = bottomMargin {
            snackbar.bottomMargin = btmMargin
        }
        switch type {
        case .default:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .success
        case .success:
            snackbar.backgroundColor = .green
            feedbackType = .success
        case .critical:
            snackbar.backgroundColor = .textCritical
            feedbackType = .error
        case .neutral:
            snackbar.backgroundColor = .textPrimary
            feedbackType = .warning
        }
        impactGenerator.notificationOccurred(feedbackType)
        self.snackbar?.removeFromSuperview()
        self.snackbar = snackbar
        snackbar.show()
        return snackbar
    }
}
