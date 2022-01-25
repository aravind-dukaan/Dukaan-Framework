//
//  FontProvider.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import UIKit

public enum FontWeight: String {
    case regular
    case medium
    case semiBold
    case italic
    case bold
}

public protocol FontProvider {
    var heading1: UIFont { get }
    var heading2: UIFont { get } // largeTitle
    var heading3: UIFont { get } // title1
    var heading4: UIFont { get } // title2
    var heading5: UIFont { get } // title3
    var heading6: UIFont { get }
    var heading7: UIFont { get }
    var title1: UIFont { get } // headline
    var title2: UIFont { get }
    var subtitle1: UIFont { get } // subheadline
    var subtitle2: UIFont { get }
    var subtitle3: UIFont { get }
    var body1: UIFont { get }
    var body2: UIFont { get }
    var body3: UIFont { get } // body
    var subBody1: UIFont { get } // caption1
    var subBody2: UIFont { get }
    var caption1: UIFont { get } // caption2
    var caption2: UIFont { get }
    var footnote: UIFont { get } // footnote
    var statusType: UIFont {get}

    func font(ofSize size: CGFloat, weight: FontWeight) -> UIFont
}

public struct DefaultFontProvider: FontProvider {
    
    public var heading1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 24)!
        return font
    }
    
    public var heading2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 20)!
        return font.scaledFont(forTextStyle: .largeTitle)
    }
    
    public var heading3: UIFont {
        registerCustomFonts()

        let font = UIFont(name: FontType.medium.rawValue, size: 18)!
        return font.scaledFont(forTextStyle: .title1)
    }
    
    public var heading4: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 16)!
        return font.scaledFont(forTextStyle: .title2)
    }
    
    public var heading5: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 14)!
        return font.scaledFont(forTextStyle: .title2)
    }
    
    public var heading6: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.semiBold.rawValue, size: 12)!
        return font
    }
    
    public var heading7: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.bold.rawValue, size: 22)!
        return font
    }
    
    public var title1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 16)!
        return font.scaledFont(forTextStyle: .headline)
    }

    public var title2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 16)!
        return font
    }
        
    public var subtitle1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 15)!
        return font.scaledFont(forTextStyle: .subheadline)
    }
    
    public var subtitle2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 15)!
        return font
    }
    
    public var subtitle3: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 15)!
        return font.scaledFont(forTextStyle: .subheadline)
    }
    
    public var body1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 14)!
        return font.scaledFont(forTextStyle: .body)
    }
    
    public var body2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 14)!
        return font
    }
    
    public var body3: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 14)!
        return font.scaledFont(forTextStyle: .body)
    }
    
    public var subBody1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 13)!
        return font.scaledFont(forTextStyle: .caption1)
    }
    
    public var subBody2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 13)!
        return font
    }
    
    public var caption1: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.regular.rawValue, size: 12)!
        return font.scaledFont(forTextStyle: .caption2)
    }
    
    public var caption2: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 12)!
        return font
    }
    
    public var footnote: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.medium.rawValue, size: 11)!
        return font.scaledFont(forTextStyle: .footnote)
    }
    
    public var statusType: UIFont {
        registerCustomFonts()
        
        let font = UIFont(name: FontType.italic.rawValue, size: 14)!
        return font
    }
    
    public func font(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .medium:
            return UIFont(name: FontType.medium.rawValue, size: size)!
        case .regular:
            return UIFont(name: FontType.regular.rawValue, size: size)!
        case .semiBold:
            return UIFont(name: FontType.semiBold.rawValue, size: size)!
        case .italic:
            return UIFont(name: FontType.italic.rawValue, size: size)!
        case .bold:
            return UIFont(name: FontType.bold.rawValue, size: size)!
        }

    }
    
    private func registerCustomFonts() {
        _ = FontRegistrator.registerCustomFonts
    }

}

// MARK: - Dukaan Font types

public enum FontType: String {
    case regular = "galanogrotesque-regular"
    case medium = "galanogrotesque-medium"
    case semiBold = "galanogrotesque-semibold"
    case italic = "galanogrotesque-italic"
    case bold = "galanogrotesquealt-bold"
}

// https://medium.com/swift-and-ios-writing/a-quick-look-at-gcd-and-swift-3-732bef6e1838
// https://stackoverflow.com/questions/37801407/whither-dispatch-once-in-swift-3/37801408
// Registering fonts, only once instead of each time.
public final class FontRegistrator {
    static let registerCustomFonts = FontRegistrator()
    init() {
        UIFont.registerFont(with: FontType.medium.rawValue)
        UIFont.registerFont(with: FontType.regular.rawValue)
        UIFont.registerFont(with: FontType.semiBold.rawValue)
        UIFont.registerFont(with: FontType.italic.rawValue)
        UIFont.registerFont(with: FontType.bold.rawValue)
    }
}

// MARK: - Private extensions

private extension UIFont {
    static func registerFont(with filenameString: String) {
        if let bundleURL = Bundle.main.url(forResource: filenameString, withExtension: "otf") {
            if let bundle = Bundle(url: bundleURL) {
                registerFontFor(bundle: bundle, forResource: filenameString)
                return
            }
        }

        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            if let bundle = Bundle(identifier: bundleIdentifier) {
                registerFontFor(bundle: bundle, forResource: filenameString)
            }
        }
    }

    private static func registerFontFor(bundle: Bundle, forResource: String) {
        guard let pathForResourceString = bundle.path(forResource: forResource, ofType: "otf") else {
            print("UIFont+: Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+: Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+: Failed to register font - data provider could not be loaded.")
            return
        }

        guard let fontRef = CGFont(dataProvider) else {
            print("UIFont+: Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(fontRef, &errorRef)
    }
}
