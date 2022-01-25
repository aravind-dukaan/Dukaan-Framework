//
//  CustomSearchTextField.swift
//  Dukaan
//
//  Created by Raja Earla on 22/06/21.
//

import Foundation
import UIKit

protocol CustomSearchTextFieldDelegate: AnyObject {
    func searchBar(_ searchBar: CustomSearchTextField, textDidChange searchText: String)
    func onClearSearchText(_ searchBar: CustomSearchTextField)
    func textFieldDidStartEditing(_ searchField: CustomSearchTextField)
}

extension CustomSearchTextFieldDelegate {
    func textFieldDidStartEditing(_ searchField: CustomSearchTextField) { }
    func onClearSearchText(_ searchBar: CustomSearchTextField) { }
    func searchBar(_ searchBar: CustomSearchTextField, textDidChange searchText: String) { }
}

class CustomSearchTextField: UIView {
    
    private var leftView: UIView? = nil {
        didSet {
            guard let view = leftView else {return}
            textField.leftView = view
            textField.leftViewMode = .always
        }
    }
    
    private var rightView: UIView? {
        didSet {
            guard let view = rightView else {return}
            textField.rightView = view
            textField.rightViewMode = .always
        }
    }
    
    var clearButtonColor: UIColor = .textPrimary {
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
    
    public private(set) lazy var textField: SearchTextFieldV2 = {
        let field = SearchTextFieldV2()
        field.textColor = .textPrimary
        field.delegate = self
        field.placeholder = "Search"
        field.font = .subtitle2
        field.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
        field.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        field.backgroundColor = .white
        field.roundedCorner(radius: 4)
        return field
    }()
    
    weak var delegate: CustomSearchTextFieldDelegate?
    var topSpacing: CGFloat = .spacing16
    private var isViewConfigured: Bool = false
    
    convenience init(_ topSpacing: CGFloat = .spacing16) {
        self.init(frame: .zero)
        self.topSpacing = topSpacing
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .primaryBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }
    @objc func editingDidBegin() {
        delegate?.textFieldDidStartEditing(self)
    }
    @objc func handleTextFieldDidChange() {
        if let text = textField.text {
            delegate?.searchBar(self, textDidChange: text)
            textField.closeButton.isHidden = text.isEmpty
        } else {
            textField.closeButton.isHidden = true
        }
    }
    
    //    @objc func clearButtonTapped() {
    //        if !closeButton.isHidden {
    //            textField.text = nil
    //            delegate?.searchBar(self, textDidChange: "")
    //            closeButton.isHidden = true
    //        }
    //    }
    
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
    
    func configureTextField() {
        textField.onClearTextBlock = { _ in
            self.delegate?.onClearSearchText(self)
        }
    }
}

private extension CustomSearchTextField {
    
    func setup() {
        
        if !isViewConfigured {
            addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacing16),
                textField.topAnchor.constraint(equalTo: topAnchor, constant: topSpacing),
                textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: topSpacing.negate),
                textField.heightAnchor.constraint(equalToConstant: 40),
                textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .spacing16.negate)
            ])
            configureTextField()
            isViewConfigured = true
        }
    }
}

extension CustomSearchTextField: UITextFieldDelegate {
    
}

extension CustomSearchTextField {
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

typealias OnClearTextClosure = ((_ text: String) -> Void)

class SearchTextFieldV2: UITextField {
    var onClearTextBlock: OnClearTextClosure?
    
    var clearButtonColor: UIColor = .bgSecondary {
        didSet {
            if let clearButton = value(forKey: "_clearButton") as? UIButton {
                // Create a template copy of the original button image
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                // Set the template image copy as the button image
                clearButton.setImage(templateImage, for: .normal)
                // Finally, set the image color
                clearButton.tintColor = clearButtonColor
            }
        }
    }
    
    private lazy var searchIcon: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 34, height: 18)
        let imageView = UIImageView()
        // imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 10, y: 0, width: 18, height: 18)
       // imageView.image = R.image.custom_search()
        view.addSubview(imageView)
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .textPrimary
      //  button.setImage(R.image.search_close(), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: .spacing20, height: .spacing20)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var closeButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 30, height: .spacing20)
        view.addSubview(closeButton)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .textPrimary
        placeholder = "Search"
        font = .subtitle2
        backgroundColor = .white
        roundedCorner(radius: 4)
        leftView = searchIcon
        leftViewMode = .always
        
        rightView = closeButtonView
        rightViewMode = .always
    }
    
    @objc func clearButtonTapped() {
        if !closeButton.isHidden {
            text = nil
            closeButton.isHidden = true
            if let clearBlock = onClearTextBlock {
                clearBlock("")
            }
        }
    }
    func changePlaceholderColor(_ color: UIColor) {
        guard let placeholder = placeholder else {return}
        if #available(iOS 13, *) {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIConfig.fontProvider.font(ofSize: 16, weight: .regular)])
        } else {
            guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel") else {
                return
            }
            for subview in subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
                if let sv = subview as? UILabel {
                    sv.textColor = color
                    sv.font = UIConfig.fontProvider.font(ofSize: 16, weight: .regular)
                }
            }
        }
    }
}
