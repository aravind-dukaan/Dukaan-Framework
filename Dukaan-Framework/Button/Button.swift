//
//  Button.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import UIKit
import CoreGraphics

var ctaButtonHeight: CGFloat = 48

public class Button: UIButton {
    // MARK: - Internal properties

    private let cornerRadius: CGFloat = 8.0
    private var titleHeight: CGFloat?
    private var titleWidth: CGFloat?
    var imageTitlePadding: ImagePositionPadding?

    // MARK: - External properties

    public var style: Style {
        didSet { setup() }
    }

    public var size: Size {
        didSet { setup() }
    }

    // MARK: - Initializers

    public init(style: Style, size: Size = .normal, withAutoLayout: Bool = false) {
        self.style = style
        self.size = size
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !withAutoLayout
        setup()
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(style: .default)
    }

    // MARK: - Overrides

    public override var isHighlighted: Bool {
        didSet {
            backgroundColor = style.backgroundColor(forState: state)
            layer.borderColor = style.borderColor(forState: state)
        }
    }

    public override var isEnabled: Bool {
        didSet {
            backgroundColor = style.backgroundColor(forState: state)
            layer.borderColor = style.borderColor(forState: state)
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            backgroundColor = style.backgroundColor(forState: state)
            layer.borderColor = style.borderColor(forState: state)
        }
    }

    public override var intrinsicContentSize: CGSize {
        guard let titleWidth = titleWidth, let titleHeight = titleHeight else {
            return CGSize.zero
        }
//        let paddings = style.paddings(forSize: size)
        let imageSize = imageView?.image?.size ?? .zero
        var calcWidth = titleWidth + imageSize.width + style.margins.left + style.margins.right

        if #available(iOS 15.0, *) {
            if style == .radio {
                calcWidth += 10
            }
        }
        if let imagePadding = imageTitlePadding, !imageSize.width.isZero {
            switch imagePadding.position {
            case .top, .bottom:
                break
            case .left:
                calcWidth += imagePadding.padding
            case .right:
                calcWidth += imagePadding.padding
            }
        }
        return CGSize(
            width: calcWidth,
            height: titleHeight + style.margins.top + style.margins.bottom // + paddings.top + paddings.bottom
        )
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let title = title else {
            return
        }
        if let titleHeight = style.titleHeight {
            self.titleHeight = titleHeight
        } else {
            titleHeight = title.height(withConstrainedWidth: bounds.width, font: style.font(forSize: size))
        }
        titleWidth = title.width(withConstrainedHeight: bounds.height, font: style.font(forSize: size))

        if style == .linkOrange || style == .linkOrangeRegular  || style == .linkWhite || style == .linkRed {
            setAsLink(title: title)
        } else {
            super.setTitle(title, for: state)
        }

        if state == .normal {
            accessibilityLabel = title
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        // Border color is set in a lifecycle method to ensure it is dark mode compatible.
        // Changing border color for a `Button` must be done with the `overrideStyle` method.
        layer.borderColor = style.borderColor(forState: state)
    }
    
    func setImages(right: UIImage? = nil, left: UIImage? = nil) {
        if let leftImage = left, right == nil {
            setImage(leftImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: (imageView?.frame.width)!)
            contentHorizontalAlignment = .left
        }
        if let rightImage = right, left == nil {
            setImage(rightImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: (bounds.width - 35))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 10)
            contentHorizontalAlignment = .right
        }

        if let rightImage = right, let leftImage = left {
            setImage(rightImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: (bounds.width - 35))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 10)
            contentHorizontalAlignment = .left

            let leftImageView = UIImageView(frame: CGRect(x: bounds.maxX - 30,
                                                          y: (titleLabel?.bounds.midY)! - 5,
                                                          width: .spacing24,
                                                          height: frame.height - 10))
            leftImageView.image?.withRenderingMode(.alwaysOriginal)
            leftImageView.image = leftImage
            leftImageView.contentMode = .scaleAspectFit
            leftImageView.layer.masksToBounds = true
           addSubview(leftImageView)
        }

    }

    // MARK: - Private methods

    private func setup() {
        isAccessibilityElement = true

        titleEdgeInsets = style.paddings(forSize: size)
        contentEdgeInsets = style.margins
        titleLabel?.font = style.font(forSize: size)
        titleLabel?.adjustsFontForContentSizeCategory = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor?.cgColor
        backgroundColor = style.bodyColor

        // Calling super because the method is effectively disabled for this class
        super.setTitleColor(style.textColor, for: .normal)
        super.setTitleColor(style.highlightedTextColor, for: .highlighted)
        super.setTitleColor(style.disabledTextColor, for: .disabled)
    }

    private func setAsLink(title: String) {
        let textRange = NSRange(location: 0, length: title.count)
        let attributedTitle = NSMutableAttributedString(string: title)

        attributedTitle.addAttribute(.foregroundColor, value: style.textColor, range: textRange)
        let underlinedAttributedTitle = NSMutableAttributedString(string: title)

        let disabledAttributedTitle = NSMutableAttributedString(string: title)
        disabledAttributedTitle.addAttribute(
            .foregroundColor,
            value: style.disabledTextColor ?? UIColor.textDisabled,
            range: textRange
        )

        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: style.textColor
        ]
        underlinedAttributedTitle.addAttributes(underlineAttributes, range: textRange)

        super.setAttributedTitle(underlinedAttributedTitle, for: .normal)
        super.setAttributedTitle(underlinedAttributedTitle, for: .highlighted)
        super.setAttributedTitle(underlinedAttributedTitle, for: .disabled)
    }
}
