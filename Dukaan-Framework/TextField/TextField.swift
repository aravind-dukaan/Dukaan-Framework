//
//  TextField.swift
//  Dukaan
//
//  Created by Kartik on 27/01/21.
//

import Foundation
import UIKit

private let borderHeight: CGFloat = 1

@objc protocol TextFieldUIDelegate: AnyObject {
    @objc optional func textFieldDidBeginEditing(_ textField: TextField)
    @objc optional func textFieldDidEndEditing(_ textField: TextField)
    @objc optional func textFieldShouldReturn(_ textField: TextField) -> Bool
    @objc optional func textField(_ textField: TextField,
                                  shouldChangeCharactersIn range: NSRange,
                                  replacementString string: String) -> Bool
}

open class TextField: UITextField {
    
    weak var uiDelegate: TextFieldUIDelegate?
    var bottomBorder = UIView()
    var label: UILabel!
    
    var bottomBorderMargin: CGFloat?
    
    var prefix: String? {
        didSet {
            self.updatePrefix()
        }
    }
    
    var showErrorType: Bool = false {
        didSet {
            bottomBorder.backgroundColor = showErrorType ? .textCritical : .separatorColour
        }
    }
    
    override open var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updatePlaceholder()
        }
    }

    /// A UIFont value that determines text color of the placeholder label
    var placeholderFont: UIFont? {
        didSet {
            updatePlaceholder()
        }
    }
    
    convenience init(_ bottomBorderMargin: CGFloat? = nil) {
        self.init(frame: .zero)
        self.bottomBorderMargin = bottomBorderMargin
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.delegate = self
        isUserInteractionEnabled = true
    }
    
    open override func draw(_ rect: CGRect) {
        if let customMargin = bottomBorderMargin {
            self.bottomBorder.frame = CGRect(x: 0,
                                             y: self.frame.height - customMargin,
                                             width: self.bounds.width,
                                             height: borderHeight)
        
        } else {
            self.bottomBorder.frame = CGRect(x: 0,
                                             y: self.frame.height + .spacing2,
                                             width: self.bounds.width,
                                             height: borderHeight)
        }
        self.bottomBorder.backgroundColor = .separatorColour
        self.addSubview(bottomBorder)
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }
    
    private func updatePrefix() {
        self.leftViewMode = UITextField.ViewMode.always
        if let text = prefix {
            // Bounds of prefix
//            let textWidth = text.widthOfString(usingFont: self.font ?? .title2) + .spacing2
            let labelFrame = CGRect(x: 5, y: 0, width: 50, height: self.bounds.height)
            label = UILabel(frame: labelFrame)
            label.textColor = self.textColor
            label.font = self.font // Customize font
            label.text = text
            label.textAlignment = .left
            self.leftView = label
        }
    }
    
    func updateSuffix(font: UIFont) {
        label.font = font
    }
    
    fileprivate func updatePlaceholder() {
        guard let placeholder = placeholder, let font = placeholderFont ?? font else {
            return
        }
        let color = isEnabled ? placeholderColor : placeholderColor
        
        #if swift(>=4.2)
        let attributedString = NSMutableAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font ])
        let range =  (placeholder as NSString).range(of: "*")
        attributedString.addAttribute(.foregroundColor, value: UIColor.textCritical, range: range)

            attributedPlaceholder = attributedString
        #elseif swift(>=4.0)
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font
                ]
            )
        #else
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
            )
        #endif
    }
}

// MARK: UITextFieldDelegate Methods
extension TextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.bottomBorder.backgroundColor = .primaryBlue
        if let textField = textField as? TextField {
            self.uiDelegate?.textFieldDidBeginEditing?(textField)
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomBorder.backgroundColor = .separatorColour
        if let textField = textField as? TextField {
            self.uiDelegate?.textFieldDidEndEditing?(textField)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField as? TextField {
            return self.uiDelegate?.textFieldShouldReturn?(textField) ?? false
        }
        return false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textField = textField as? TextField {
            return self.uiDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
        }
        return false
    }
}
