//
//  Label+Style.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import Foundation
import UIKit
import CoreGraphics
 
public extension Label {
    enum Style {
        
        /// GalanoGrotesque-Medium, Size: 24pt, Line height: 32pt
        case heading1
      
        /// Scaled GalanoGrotesque-Medium, Size: 20pt, Line height: 28pt
        case heading2
   
        /// Scaled GalanoGrotesque-Medium, Size: 18pt, Line height: 26pt
        case heading3
  
        /// Scaled GalanoGrotesque-Medium, Size: 16pt, Line height: 24pt
        case heading4
   
        /// Scaled GalanoGrotesque-Medium, Size: 14pt, Line height: 20pt
        case heading5
      
        /// GalanoGrotesque-Semibold, Size: 12pt, Line height: 16pt
        case heading6
        
        /// GalanoGrotesque-Bold, Size: 22pt, Line height: 26pt
        case heading7
      
        /// Scaled GalanoGrotesque-Regular, Size: 16pt, Line height: 24pt
        case title1
       
        /// GalanoGrotesque-Medium, Size: 16pt, Line height: 20pt
        case title2
        
        /// Scaled GalanoGrotesque-Regular, Size: 15pt, Line height: 22pt
        case subtitle1
        
        /// GalanoGrotesque-Regular, Size: 15pt, Line height: 20pt
        case subtitle2
      
        /// Scaled GalanoGrotesque-Medium, Size: 15pt, Line height: 20pt
        case subtitle3
     
        /// GalanoGrotesque-Regular, Size: 14pt, Line height: 20pt
        case body1
     
        /// GalanoGrotesque-Regular, Size: 14pt, Line height: 18pt
        case body2
      
        /// Scaled GalanoGrotesque-Medium, Size: 14pt, Line height: 18pt
        case body3
     
        /// Scaled GalanoGrotesque-Regular, Size: 13pt, Line height: 16pt
        case subBody1
     
        /// GalanoGrotesque-Medium, Size: 13pt, Line height: 16pt
        case subBody2
      
        /// Scaled GalanoGrotesque-Regular, Size: 12pt, Line height: 16pt
        case caption1
      
        /// GalanoGrotesque-Medium, Size: 12pt, Line height: 16pt
        case caption2
    
        /// Scaled GalanoGrotesque-Medium, Size: 11pt, Line height: 11pt
        case footnote

        public var font: UIFont {
            switch self {
            case .heading1:
                return .heading1
            case .heading2:
                return .heading2
            case .heading3:
                return .heading3
            case .heading4:
                return .heading4
            case .heading5:
                return .heading5
            case .heading6:
                return .heading6
            case .heading7:
                return .heading7
            case .title1:
                return .title1
            case .title2:
                return .title2
            case .subtitle1:
                return .subtitle1
            case .subtitle2:
                return .subtitle2
            case .subtitle3:
                return .subtitle3
            case .body1:
                return .body1
            case .body2:
                return .body2
            case .body3:
                return .body3
            case .subBody1:
                return .subBody1
            case .subBody2:
                return .subBody2
            case .caption1:
                return .caption1
            case .caption2:
                return .caption2
            case .footnote:
                return .footnote
            }
        }
        
        var padding: UIEdgeInsets {
            return UIEdgeInsets(top: (lineSpacing - font.pointSize)/2, left: 0, bottom: (lineSpacing - font.pointSize)/2, right: 0)
        }

        var lineSpacing: CGFloat {
            switch self {
            case .heading1:
                return 32
            case .heading2:
                return 28
            case .heading3:
                return 26
            case .heading4:
                return 24
            case .heading5:
                return 20
            case .heading6:
                return 16
            case .heading7:
                return 24
            case .title1:
                return 24
            case .title2:
                return 20
            case .subtitle1:
                return 22
            case .subtitle2:
                return 20
            case .subtitle3:
                return 20
            case .body1:
                return 20
            case .body2:
                return 18
            case .body3:
                return 18
            case .subBody1:
                return 16
            case .subBody2:
                return 16
            case .caption1:
                return 16
            case .caption2:
                return 16
            case .footnote:
                return 11
            }
        }        
    }
}
