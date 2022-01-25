//
//  Spacing.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import Foundation
import CoreGraphics
import UIKit

public extension CGFloat {
    /// Separation of 2 points.
    static let spacing2: CGFloat = 2

    /// Separation of 4 points.
    static let spacing4: CGFloat = 4
    
    /// Separation of 4 points.
    static let spacing6: CGFloat = 6

    /// Separation of 8 points.
    static let spacing8: CGFloat = 8

    /// Separation of 12 points.
    static let spacing12: CGFloat = 12
    
    /// Separation of 14 points.
    static let spacing14: CGFloat = 14
    
    /// Separation of 16 points.
    static let spacing16: CGFloat = 16

    /// Separation of 20 points.
    static let spacing20: CGFloat = 20
    
    static let spacing22: CGFloat = 22

    /// Separation of 24 points.
    static let spacing24: CGFloat = 24

    /// Separation of 32 points.
    static let spacing32: CGFloat = 32

    /// Separation of 64 points.
    static let spacing64: CGFloat = 64
    
    var negate: CGFloat {
        return -self
    }
}

public extension CGFloat {
    /**
     Converts pixels to points based on the screen scale. For example, if you
     call CGFloat(1).pixelsToPoints() on an @2x device, this method will return
     0.5.
     
     - parameter pixels: to be converted into points
     
     - returns: a points representation of the pixels
     */
    func pixelsToPoints() -> CGFloat {
        return self / UIScreen.main.scale
    }
    
    /**
     Returns the number of points needed to make a 1 pixel line, based on the
     scale of the device's screen.
     
     - returns: the number of points needed to make a 1 pixel line
     */
    static func onePixelInPoints() -> CGFloat {
        return CGFloat(1).pixelsToPoints()
    }
}
