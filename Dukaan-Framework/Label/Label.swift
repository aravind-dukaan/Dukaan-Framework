//
//  Label.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import UIKit
import CoreFoundation
public class Label: UILabel {

    // MARK: - Public properties

    public private(set) var isTextCopyable = false

    // MARK: - Setup

    public init(style: Style, withAutoLayout: Bool = false) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = !withAutoLayout
        self.style = style
        setup()
    }

    public init(style: Style, color: UIColor, withAutoLayout: Bool = false ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = withAutoLayout
        self.style = style
        self.textColor = color
        setup()
    }
    
    public init(style: Style, color: UIColor, backgroundColor: UIColor, withAutoLayout: Bool = false ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = withAutoLayout
        self.style = style
        self.textColor = color
        self.backgroundColor = backgroundColor
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:))))

        isAccessibilityElement = true

        accessibilityLabel = text
        font = style?.font
        adjustsFontForContentSizeCategory = true
    }

    public override var text: String? {
        didSet {
            if let style = style {
                attributedText = text?.attributedString(with: style.lineSpacing,
                                                        font: font,
                                                        textColor: textColor,
                                                        alignment: textAlignment)
            }
        }
    }
    
    // MARK: - Public methods

    public func setTextCopyable(_ isTextCopyable: Bool) {
        self.isTextCopyable = isTextCopyable
        isUserInteractionEnabled = isTextCopyable
    }

//    public override func drawText(in rect: CGRect) {
//        super.drawText(in: rect.inset(by: style?.padding ?? .zero))
//    }
    
//    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        let insets = style?.padding ?? .zero
//        let insetRect = bounds.inset(by: insets)
//        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
//        let invertedInsets = UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)
//        return textRect.inset(by: invertedInsets)
//    }

    // MARK: - Dependency injection

    public private(set) var style: Style?
}

// MARK: - Copying extension

extension Label {
    public override var canBecomeFirstResponder: Bool { isTextCopyable }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(copy(_:))
    }

    public override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }

    @objc private func handleLongPress(_ recognizer: UIGestureRecognizer) {
        guard recognizer.state == .began else { return }

        becomeFirstResponder()
        let textRect = self.textRect(forBounds: bounds, limitedToNumberOfLines: 1)
        UIMenuController.shared.setTargetRect(textRect, in: self)
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
}

public class View: UIView {
    
    public init(frame: CGRect = .zero, radius: CGFloat) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .bgSecondary
        roundAll(radius: radius)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bgSecondary
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init(frame: CGRect = .zero, color: UIColor = .clear) {
        super.init(frame: frame)
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
