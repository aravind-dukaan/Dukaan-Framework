//
//  DukaanConfig.swift
//  MyFramework
//
//  Created by Aravind on 19/01/22.
//

import Foundation

public enum UserInterfaceStyleSupport {
    @available(iOS 13.0, *)
    case dynamic
    case forceLight
    case forceDark
}
public struct UIConfig {
    public static var bundle: Bundle { Bundle.main }
    public static var fontProvider: FontProvider = DefaultFontProvider()
    //    public static var colorProvider: ColorProvider = DefaultColorProvider()
    public static var isDynamicTypeEnabled: Bool = true
    public static var userInterfaceStyleSupport: UserInterfaceStyleSupport = {
        if #available(iOS 13.0, *) {
            return .dynamic
        } else {
            return .forceLight
        }
    }()
}
