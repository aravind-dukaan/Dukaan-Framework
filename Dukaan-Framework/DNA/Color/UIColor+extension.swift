//
//  UIColor+extension.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import Foundation
import UIKit
import CoreGraphics
import Foundation.NSAttributedString

// MARK: - Dukaan UIColors
@objc extension UIColor {

    /// UIColor with rgb 242 242 242, hex: E6E6E6
    public class var bgPrimary: UIColor {
        return .black95
    }
    
    /// white
    public class var bgSecondary: UIColor {
        return UIColor.white
    }

    /// UIColor with rgb 26 24 30, hex: 1A181E
    public class var primaryBlack: UIColor {
        return UIColor.black12
    }

    /// UIColor with rgb 26 24 30, hex: 1A181E
    public class var black12: UIColor {
        return UIColor(hex: "1A181E")
    }

    /// UIColor with rgb 77 77 77, hex: 4D4D4D
    public class var black30: UIColor {
        return UIColor(hex: "4D4D4D")
    }

    /// UIColor with rgb 128 128 128, hex: 808080
    public class var black50: UIColor {
        return UIColor(hex: "808080")
    }

    /// UIColor with rgb 153 153 153, hex: 999999
    public class var black60: UIColor {
        return UIColor(hex: "999999")
    }

    /// UIColor with rgb 178 178 178, hex: B2B2B2
    public class var black70: UIColor {
        return UIColor(hex: "B2B2B2")
    }

    /// UIColor with rgb 217 217 217, hex: D9D9D9
    public class var black85: UIColor {
        return UIColor(hex: "D9D9D9")
    }

    /// UIColor with rgb 229 229 229, hex: E6E6E6
    public class var black90: UIColor {
        return UIColor(hex: "E6E6E6")
    }

    /// UIColor with rgb 242 242 242, hex: F2F2F2
    public class var black95: UIColor {
        return UIColor(hex: "F2F2F2")
    }

    /// UIColor with rgb 250 250 250, hex: FAFAFA
    public class var black98: UIColor {
        return UIColor(hex: "FAFAFA")
    }
    
    /// UIColor with rgb 250 250 250, hex: FAFAFA
    public class var black100: UIColor {
        return UIColor(hex: "FFFFFF")
    }

    /// UIColor with rgb 26 24 30, hex: 1A181E
    public class var textPrimary: UIColor {
        return UIColor.black12
    }
    
    /// UIColor with rgb 128 128 128, hex: 808080
    public class var textSecondary: UIColor {
        return UIColor.black50
    }
    
    /// UIColor with rgb 229 11 32, hex: E50B20
    public class var textCritical: UIColor {
        return UIColor.red
    }
    
    /// UIColor with rgb 20 110 180
    public class var primaryBlue: UIColor {
        return UIColor(hex: "146EB4")
    }
    
    /// UIColor with rgb 20 110 180
    public class var secondaryBlue: UIColor {
        return UIColor(hex: "146EB4").withAlphaComponent(0.1)
    }
        
    /// UIColor with rgb 238 116 31 hex: EE741F
    public class var orange: UIColor {
        return UIColor(hex: "EE741F")
    }
    
    /// UIColor with rgb 23 179 27, hex 17B31B
    public class var green: UIColor {
        return UIColor(hex: "17B31B")
    }

    /// UIColor with rgb 23 179 27, hex 17B31B alpha 0.1
    public class var secondaryGreen: UIColor {
        return green.withAlphaComponent(0.1)
    }

    /// UIColor with rgb 250 183 59, hex FAB73B
    public class var yellow: UIColor {
        return UIColor(hex: "FAB73B")
    }

    /// UIColor with rgb 229 11 32, hex E50B20
    public class var red: UIColor {
        return UIColor(hex: "E50B20")
    }
    
    /// UIColor with rgb 223 30 91, hex DF1E5B
    public class var raspberry: UIColor {
        return UIColor(hex: "DF1E5B")
    }
    
    /// UIColor with rgb 217 217 217 hex: D9D9D9
    public class var separatorColour: UIColor {
        return UIColor.black85
    }
    
    public class var textDisabled: UIColor {
        return UIColor.white.withAlphaComponent(0.4)
    }

    public class var darkMint: UIColor {
        return UIColor(hex: "49c759")
    }
    
    public class var randomColor: UIColor {
        /// Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - Dukaan CGColors
extension CGColor {
    public class var primaryBlue: CGColor {
        return UIColor.primaryBlue.cgColor
    }
}

// MARK: - Semantic CGColors
extension CGColor {
    public class var bgPrimary: CGColor {
        return UIColor.bgPrimary.cgColor
    }

    public class var bgSecondary: CGColor {
        return UIColor.bgSecondary.cgColor
    }

    /// UIColor with rgb 26 24 30, hex: 1A181E
    public class var black12: CGColor {
        return UIColor.black12.cgColor
    }

    /// UIColor with rgb 77 77 77, hex: 4D4D4D
    public class var black30: CGColor {
        return UIColor.black30.cgColor
    }

    /// UIColor with rgb 128 128 128, hex: 808080
    public class var black50: CGColor {
        return UIColor.black50.cgColor
    }

    /// UIColor with rgb 153 153 153, hex: 999999
    public class var black60: CGColor {
        return UIColor.black60.cgColor
    }

    /// UIColor with rgb 178 178 178, hex: B2B2B2
    public class var black70: CGColor {
        return UIColor.black70.cgColor
    }

    /// UIColor with rgb 217 217 217, hex: D9D9D9
    public class var black85: CGColor {
        return UIColor.black85.cgColor
    }

    /// UIColor with rgb 229 229 229, hex: E6E6E6
    public class var black90: CGColor {
        return UIColor.black90.cgColor
    }

    /// UIColor with rgb 242 242 242, hex: E6E6E6
    public class var black95: CGColor {
        return UIColor.black95.cgColor
    }

    /// UIColor with rgb 250 250 250, hex: FAFAFA
    public class var black98: CGColor {
        return UIColor.black98.cgColor
    }
}

// MARK: - Button UIColors
@objc extension UIColor {
    public class var callToActionButtonHighlightedBodyColor: UIColor {
        return primaryBlue.withAlphaComponent(0.8)
    }
}

// MARK: - Highlighted buttons CGColors
extension CGColor {
    public class var callToActionButtonHighlightedBodyColor: CGColor {
        return UIColor.callToActionButtonHighlightedBodyColor.cgColor
    }

}

// MARK: - Cell UIColors

@objc extension UIColor {
    public class var defaultCellSelectedBackgroundColor: UIColor {
        let lightSelectedColor = UIColor(r: 230, g: 235, b: 242)
        return dynamicColorIfAvailable(defaultColor: lightSelectedColor, darkModeColor: lightSelectedColor.withAlphaComponent(0.1))
    }
}

extension CGColor {
    public class var defaultCellSelectedBackgroundColor: CGColor {
        return UIColor.defaultCellSelectedBackgroundColor.cgColor
    }
}

// MARK: - Public color creation methods
public extension UIColor {
    /// The UIColor initializer we need it's more natural to write integer values from 0 to 255 than decimas from 0 to 1
    /// - Parameters:
    ///   - r: red (0-255)
    ///   - g: green (0-255)
    ///   - b: blue (0-255)
    ///   - a: alpla (0-1)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) { // swiftlint:disable:this identifier_name
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /// Base initializer, it creates an instance of `UIColor` using an HEX string.
    ///
    /// - Parameter hex: The base HEX string to create the color.
    convenience init(hex: String) {
        let noHashString = hex.replacingOccurrences(of: "#", with: "").trim
        let scanner = Scanner(string: noHashString)
        scanner.charactersToBeSkipped = CharacterSet.symbols

        var hexInt: UInt32 = 0
        if scanner.scanHexInt32(&hexInt) {
            let red = (hexInt >> 16) & 0xFF
            let green = (hexInt >> 8) & 0xFF
            let blue = (hexInt) & 0xFF

            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        } else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    convenience init(_ hexDecimal: String) {
        let noHashString = hexDecimal.replacingOccurrences(of: "#", with: "").trim
        let scanner      = Scanner(string: noHashString)
        scanner.charactersToBeSkipped = CharacterSet.symbols

        var hexInt: UInt32 = 0
        if scanner.scanHexInt32(&hexInt) {
            let red   = (hexInt >> 16) & 0xFF
            let green = (hexInt >> 8) & 0xFF
            let blue  = (hexInt) & 0xFF
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        } else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    /// Convenience method to create dynamic colors for dark mode if the OS supports it (independant of FinniversKit
    /// settings)
    /// - Parameters:
    ///   - defaultColor: light mode version of the color
    ///   - darkModeColor: dark mode version of the color
    class func dynamicColor(defaultColor: UIColor, darkModeColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            #if swift(>=5.1)
            return UIColor { traitCollection -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return darkModeColor
                default:
                    return defaultColor
                }
            }
            #endif
        }
        return defaultColor
    }

    /// Convenience mehtod to create dynamic colors **considering FinniversKit settings** and if the OS supports it
    /// - Parameters:
    ///   - defaultColor: light mode version of the color
    ///   - darkModeColor: dark mode version of the color
    class func dynamicColorIfAvailable(defaultColor: UIColor, darkModeColor: UIColor) -> UIColor {
        switch UIConfig.userInterfaceStyleSupport {
        case .forceDark:
            return darkModeColor
        case .forceLight:
            return defaultColor
        case .dynamic:
            return dynamicColor(defaultColor: defaultColor, darkModeColor: darkModeColor)
        }
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let red   = CGFloat(Int(color >> 16) & mask) / 255.0
        let green = CGFloat(Int(color >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(color) & mask) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func hexStringFromColor() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format: "#%06x", rgb)
    }
}
