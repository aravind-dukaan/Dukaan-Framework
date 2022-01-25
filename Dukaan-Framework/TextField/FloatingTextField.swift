//
//  FloatingTextField.swift
//  Dukaan
//
//  Created by Kartik on 29/01/21.
//

import Foundation
import UIKit

var textFieldHeight: CGFloat = 48

protocol FloatingTextFieldDelegate: AnyObject {
    func delete(_ textField: FloatingTextField)
}

class FloatingTextField: SkyFloatingLabelTextField {
    
    weak var uiDelegate: FloatingTextFieldDelegate?
    
    var hasSuffix = false
    
    var suffix: String? {
        didSet {
            self.updateSuffix()
        }
    }
    
    var prefix: String? {
        didSet {
            self.updatePrefix()
        }
    }

    var prefixFont: UIFont?
    var suffixFont: UIFont?

    init(placeholder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = .title1
        titleFont = .caption1
        placeholderFont = .title1
        
        tintColor = .primaryBlue
        textColor = .textPrimary

        lineHeight = 1
        selectedLineHeight = 1
    
        titleColor = .textSecondary
        selectedTitleColor = .primaryBlue

        lineColor = .black85
        selectedLineColor = .primaryBlue
   
        self.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        font = .title1
    }
    
    private func updateSuffix() {
        self.rightViewMode = UITextField.ViewMode.always
        if let text = suffix {
            // Bounds of suffix
            let label = UILabel(frame: .zero)
            rightView = label
            label.textColor = self.textColor
            if let font = self.suffixFont {
                label.font = font
            } else {
                label.font = self.font
            }
            label.text = text
            layoutSubviews()
        }
    }
    
    private func updatePrefix() {
        self.leftViewMode = UITextField.ViewMode.always
        if let text = prefix {
            // Bounds of suffix
            let label = UILabel(frame: .zero)
            leftView = label
            label.textColor = self.textColor
            if let font = self.prefixFont {
                label.font = font
            } else {
                label.font = self.font
            }
            label.text = text
            layoutSubviews()
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.y += 7
        return textRect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var placeholderRect = super.placeholderRect(forBounds: bounds)
        let originX = prefix != nil ? placeholderRect.origin.x + (leftView?.frame.width ?? 20) : 0
        placeholderRect = CGRect(x: originX, y: placeholderRect.origin.y, width: placeholderRect.width, height: placeholderRect.height)
        return placeholderRect
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        uiDelegate?.delete(self)
    }
    
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        if hasSuffix {
            let beginning = self.beginningOfDocument
            guard let text = text else {
                return super.closestPosition(to: point)
            }
            let end = self.position(from: beginning, offset: text.count - 1)
            return end
        }
        return super.closestPosition(to: point)
    }
}
