//
//  UIFont+extension.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import UIKit


@objc public extension UIFont {
    
    /// GalanoGrotesque-Medium, Size: 24pt
    class var heading1: UIFont {
        UIConfig.fontProvider.heading1
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 20pt
    class var heading2: UIFont {
        UIConfig.fontProvider.heading2
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 18pt
    class var heading3: UIFont {
        UIConfig.fontProvider.heading3
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 16pt
    class var heading4: UIFont {
        UIConfig.fontProvider.heading4
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 14pt
    class var heading5: UIFont {
        UIConfig.fontProvider.heading5
    }
    
    /// GalanoGrotesque-Semibold, Size: 12pt
    class var heading6: UIFont {
        UIConfig.fontProvider.heading6
    }
    
    /// GalanoGrotesque-Bold, Size: 22pt
    class var heading7: UIFont {
        UIConfig.fontProvider.heading7
    }
    
    /// Scaled GalanoGrotesque-Regular, Size: 16pt
    class var title1: UIFont {
        UIConfig.fontProvider.title1
    }
    
    /// GalanoGrotesque-Medium, Size: 16pt
    class var title2: UIFont {
        UIConfig.fontProvider.title2
    }
    
    /// Scaled GalanoGrotesque-Regular, Size: 15pt
    class var subtitle1: UIFont {
        UIConfig.fontProvider.subtitle1
    }
    
    /// GalanoGrotesque-Regular, Size: 15pt
    class var subtitle2: UIFont {
        UIConfig.fontProvider.subtitle2
    }
    
    /// GalanoGrotesque-Medium, Size: 15pt
    class var subtitle3: UIFont {
        UIConfig.fontProvider.subtitle3
    }
    
    /// GalanoGrotesque-Regular, Size: 14pt
    class var body1: UIFont {
        UIConfig.fontProvider.body1
    }
    
    /// GalanoGrotesque-Regular, Size: 14pt
    class var body2: UIFont {
        UIConfig.fontProvider.body2
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 14pt
    class var body3: UIFont {
        UIConfig.fontProvider.body3
    }
    
    /// Scaled GalanoGrotesque-Regular, Size: 13pt
    class var subBody1: UIFont {
        UIConfig.fontProvider.subBody1
    }
    
    /// GalanoGrotesque-Medium, Size: 13pt
    class var subBody2: UIFont {
        UIConfig.fontProvider.subBody2
    }
    
    /// Scaled GalanoGrotesque-Regular, Size: 12pt
    class var caption1: UIFont {
        UIConfig.fontProvider.caption1
    }
    
    /// GalanoGrotesque-Medium, Size: 12pt
    class var caption2: UIFont {
        UIConfig.fontProvider.caption2
    }
    
    /// Scaled GalanoGrotesque-Medium, Size: 11pt
    class var footnote: UIFont {
        UIConfig.fontProvider.footnote
    }
    
    /// GalanoGrotesque-Italic, Size: 14pt
    class var statusType: UIFont {
        UIConfig.fontProvider.statusType
    }
    
    func scaledFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return self
//        if UIConfig.isDynamicTypeEnabled {
//            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
//            return fontMetrics.scaledFont(for: self)
//        } else {
//            return self
//        }
    }
}

public extension UIFont {
    class func font(ofSize size: CGFloat, weight: FontWeight, textStyle: UIFont.TextStyle) -> UIFont {
        UIConfig.fontProvider.font(ofSize: size, weight: weight).scaledFont(forTextStyle: textStyle)
    }
}
