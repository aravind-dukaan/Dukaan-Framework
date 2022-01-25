//
//  CheckboxButton.swift
//  Dukaan
//
//  Created by Kartik on 15/02/21.
//

import Foundation
import UIKit


class CheckboxButton: Button {
    
    public init(title: String) {
        super.init(style: .checkBox)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        //setImage(R.image.checkboxSelected(), for: .selected)
        //setImage(R.image.checkboxUnselected(), for: .normal)
        //setImage(R.image.checkboxUnselected(), for: .highlighted)
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       leading: -10,
                                       bottom: 0,
                                       trailing: 10)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

}

class MultiLineCheckboxButton: Button {
    
    public init(title: String) {
        super.init(style: .checkBox)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
//        setImage(R.image.checkboxSelected(), for: .selected)
//        setImage(R.image.checkboxUnselected(), for: .normal)
//        setImage(R.image.checkboxUnselected(), for: .highlighted)
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       leading: -10,
                                       bottom: 0,
                                       trailing: 10)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override var intrinsicContentSize: CGSize {
           let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
           let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)

           return desiredButtonSize
    }
}
