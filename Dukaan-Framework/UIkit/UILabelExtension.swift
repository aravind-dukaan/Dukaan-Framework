//
//  UILabelExtension.swift
//  Dukaan
//
//  Created by Raja Earla on 19/04/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineSpacing(_ lineSpacing: CGFloat = 0.0, _ lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func lineSpacing(_ space: CGFloat, _ align: NSTextAlignment = .left) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = align
//        paragraphStyle.minimumLineHeight = 24
        var currentText = ""
        if let cText = self.text {
            currentText = cText
        } else if let attrText = self.attributedText {
            currentText = attrText.string
        }
        let attrString = NSMutableAttributedString(string: currentText)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        if let textFont = font {
            attrString.addAttributes([NSAttributedString.Key.font: textFont], range: NSRange(location: 0, length: attrString.length))
        }
        if let textColor = textColor {
            attrString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: attrString.length))
        }
        attributedText = attrString
    }
    
    func lineSpacingAlone(_ space: CGFloat, _ align: NSTextAlignment = .left) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = align
//        paragraphStyle.minimumLineHeight = 24

        let attrString = NSMutableAttributedString(string: self.text ?? "")
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        attributedText = attrString
    }
    
    func markAsAsterickField() {
        guard let labelText = self.text else {
            return
        }
        let range =  (labelText as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.textCritical, range: range)
        attributedText = attributedString
    }

}

extension UILabel {
    func textHeight(withWidth width: CGFloat) -> CGFloat {
       guard let text = text else {
          return 0
       }
        return text.height(withConstrainedWidth: width, font: font)
    }
    
    func underline() {
        let title = text ?? (attributedText?.string ?? "")
        let textRange = NSRange(location: 0, length: title.count)
        let attributedTitle = NSMutableAttributedString(string: title)

        attributedTitle.addAttribute(.foregroundColor, value: self.textColor ?? UIColor.black50, range: textRange)
        let underlinedAttributedTitle = NSMutableAttributedString(string: title)

        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: self.textColor ?? UIColor.black50
        ]
        underlinedAttributedTitle.addAttributes(underlineAttributes, range: textRange)

        attributedText = underlinedAttributedTitle
    }
    func centerAlignAsAttributedString() {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        guard let labelText = text else { return }
        let text = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.paragraphStyle: style])
        attributedText = text
    }
}
