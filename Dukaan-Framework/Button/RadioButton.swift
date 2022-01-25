//
//  RadioButton.swift
//  Dukaan
//
//  Created by Kartik on 15/02/21.
//

import Foundation
import UIKit

var radioButtonHeight: CGFloat = 24

class RadioButton: Button {
    var imageInset = CGFloat(10)
    
    public init(title: String) {
        super.init(style: .radio)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        //setImage(R.image.radioSelected(), for: .selected)
        //setImage(R.image.radioUnselected(), for: .normal)

        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       leading: -imageInset,
                                       bottom: 0,
                                       trailing: imageInset)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

}
