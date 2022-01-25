//
//  TextField+State.swift
//  Dukaan
//
//  Created by Kartik on 27/01/21.
//

import Foundation
import UIKit

public extension TextField {
    enum State {
        case normal
        case focus
        case disabled
        case error
        case readOnly

        var underlineHeight: CGFloat {
            switch self {
            case .normal, .disabled:
                return 1

            case .focus, .error:
                return 2

            case .readOnly:
                return 0
            }
        }

        var underlineColor: UIColor {
            switch self {
            case .normal:
                return .clear

            case .disabled:
                return .clear

            case .focus:
                return .primaryBlue

            case .error:
                return .textCritical

            case .readOnly:
                return .clear
            }
        }

        var textFieldBackgroundColor: UIColor {
            switch self {
            case .disabled, .readOnly:
                return .clear

            case .normal, .focus, .error:
                return .bgSecondary
            }
        }

        var accessoryLabelTextColor: UIColor {
            switch self {
            case .disabled, .readOnly, .normal, .focus:
                return .textPrimary

            case .error:
                return .textCritical
            }
        }
    }
}
