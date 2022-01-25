//
//  SearchBar.swift
//  Dukaan
//
//  Created by Raja Earla on 25/03/21.
//

import UIKit
import Foundation

class SearchBar: UISearchBar {

    var leftView: UIView? {
        didSet {
            guard let view = leftView else {return}
            textField?.leftView = view
            textField?.leftViewMode = .always
        }
    }
    
    var rightView: UIView? {
        didSet {
            guard let view = rightView else {return}
            textField?.rightView = view
            textField?.rightViewMode = .always
        }
    }
    
    var clearButtonColor: UIColor = .bgSecondary {
        didSet {
            if let clearButton = textField?.value(forKey: "_clearButton") as? UIButton {
               // Create a template copy of the original button image
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
               // Set the template image copy as the button image
                clearButton.setImage(templateImage, for: .normal)
               // Finally, set the image color
               clearButton.tintColor = clearButtonColor
            }
        }
    }

}

protocol SearchTextFieldDelegate: AnyObject {
    func searchBar(_ searchBar: SearchTextField, textDidChange searchText: String)
}

class SearchTextField: UIView {

    var dismissSearchKeyBoard:() -> Void = { }
    
    var leftView: UIView? {
        didSet {
            guard let view = leftView else {return}
            textField.leftView = view
            textField.leftViewMode = .always
        }
    }
    
    var rightView: UIView? {
        didSet {
            guard let view = rightView else {return}
            textField.rightView = view
            textField.rightViewMode = .always
        }
    }
    
    var clearButtonColor: UIColor = .bgSecondary {
        didSet {
            if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
               // Create a template copy of the original button image
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
               // Set the template image copy as the button image
                clearButton.setImage(templateImage, for: .normal)
               // Finally, set the image color
               clearButton.tintColor = clearButtonColor
            }
        }
    }
    var text: String? {
        return textField.text
    }
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .bgSecondary
        field.delegate = self
        field.placeholder = "Search"
//        field.sizeToFit()
//        field.autocorrectionType = .no
        field.font = UIConfig.fontProvider.font(ofSize: .spacing16, weight: .regular)
        field.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
        field.addTarget(self, action: #selector(dismissSearchFieldKeyBoard), for: .editingDidEndOnExit)
        return field
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        } else {
            //button.setImage(R.image.closeIcon(), for: .normal)
        }
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: .spacing24, height: .spacing24)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    weak var delegate: SearchTextFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }
    
    @objc func handleTextFieldDidChange() {
        if let text = textField.text {
            delegate?.searchBar(self, textDidChange: text)
            closeButton.isHidden = text.isEmpty
        } else {
            closeButton.isHidden = true
        }
    }
    @objc func dismissSearchFieldKeyBoard() {
        dismissSearchKeyBoard()
    }
    @objc func clearButtonTapped() {
        if !closeButton.isHidden {
            textField.text = nil
            delegate?.searchBar(self, textDidChange: "")
            closeButton.isHidden = true
        }
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        textField.resignFirstResponder()
        return true
    }
}

private extension SearchTextField {
    
    func setup() {
      
        addSubview(textField)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.widthAnchor.constraint(equalToConstant: screenWidth - (.spacing16 + .spacing8 * 3 )),
            
            closeButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: .spacing8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (.spacing12 + .spacing4).negate),
            closeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: .spacing16 + .spacing2),
            closeButton.heightAnchor.constraint(equalToConstant: .spacing16 + .spacing2)

        ])
    }
}

extension SearchTextField: UITextFieldDelegate {
    
}

extension SearchTextField {
    func changePlaceholderColor(_ color: UIColor) {
        
        if #available(iOS 13, *) {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.bgSecondary.withAlphaComponent(0.5), NSAttributedString.Key.font: UIConfig.fontProvider.font(ofSize: 16, weight: .regular)])
        } else {
            guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel") else {
                return
            }
            for subview in textField.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
                if let sv = subview as? UILabel {
                    sv.textColor = color
                    sv.font = UIConfig.fontProvider.font(ofSize: 16, weight: .regular)
                }
            }
        }
    }
}

extension UITextField {

    func placeholderColor(_ color: UIColor) {
        let customFont = UIConfig.fontProvider.font(ofSize: 16, weight: .regular)
        if #available(iOS 13, *) {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "Search here", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font ?? customFont])
        } else {
            guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel") else {
                return
            }
            for subview in subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
                if let sv = subview as? UILabel {
                    sv.textColor = color
                    sv.font = font ?? customFont
                }
            }
        }
    }
    
//    weak var placeholderColor: UITextField! {
//        didSet {
//            let redPlaceholderText = NSAttributedString(string: "My Placeholder",
//                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
//            
//            textField.attributedPlaceholder = redPlaceholderText
//        }
//    }
}
