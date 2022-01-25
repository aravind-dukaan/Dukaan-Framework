//
//  UIButton+extension.swift
//  Dukaan
//
//  Created by Kartik on 27/09/21.
//

import Foundation
import UIKit

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()

            UIView.animate(withDuration: 0.3) {
                self.isEnabled = false
                self.titleLabel?.alpha = 0
            }
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }

            UIView.animate(withDuration: 0.3) {
                self.isEnabled = true
                self.titleLabel?.alpha = 1
            }
        }
    }
}
