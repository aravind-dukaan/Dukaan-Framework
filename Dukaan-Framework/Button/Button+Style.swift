//
//  Button+Style.swift
//  Dukaan
//
//  Created by Kartik on 25/01/21.
//

import UIKit.UIGeometry
import CoreGraphics
import Foundation


public typealias ImagePositionPadding = (position: ImagePosition, padding: CGFloat)

public enum ImagePosition: Int, CaseIterable {
    case top, left, right, bottom
}

public extension Button {
    enum Size {
        case normal
        case medium
        case small
    }

    /// Convenience grouping of button state related properties
    struct StateStyle: Equatable {
        let textColor: UIColor?
        let backgroundColor: UIColor?
        let borderColor: UIColor?
    }

    struct Style: Equatable {
        let bodyColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor?
        let textColor: UIColor
        let disabledBodyColor: UIColor?
        let disabledBorderColor: UIColor?
        let highlightedBodyColor: UIColor?
        let highlightedTextColor: UIColor?
        let disabledTextColor: UIColor?
        let margins: UIEdgeInsets
        let titleHeight: CGFloat?
        let font: UIFont
        var selectedBorderColor: UIColor?
      //  var imageTitlePadding: ImagePositionPadding?

        init(
            bodyColor: UIColor,
            borderWidth: CGFloat,
            borderColor: UIColor?,
            textColor: UIColor,
            disabledBodyColor: UIColor?,
            disabledBorderColor: UIColor?,
            highlightedBodyColor: UIColor?,
            highlightedTextColor: UIColor?,
            disabledTextColor: UIColor?,
            margins: UIEdgeInsets = UIEdgeInsets(
                vertical: .spacing8,
                horizontal: .spacing16
            ),
            titleHeight: CGFloat? = nil,
            font: UIFont = .heading3,
            selectedBorderColor: UIColor?
       //     imageTitlePadding: ImagePositionPadding? = nil
        ) {
            self.bodyColor = bodyColor
            self.borderWidth = borderWidth
            self.borderColor = borderColor
            self.textColor = textColor
            self.disabledBodyColor = disabledBodyColor
            self.disabledBorderColor = disabledBorderColor
            self.highlightedBodyColor = highlightedBodyColor
            self.highlightedTextColor = highlightedTextColor
            self.disabledTextColor = disabledTextColor
            self.margins = margins
            self.titleHeight = titleHeight
            self.font = font
            self.selectedBorderColor = selectedBorderColor
         //   self.imageTitlePadding = imageTitlePadding
        }

        init(
            borderWidth: CGFloat,
            stateStyles: [UIControl.State: StateStyle],
            margins: UIEdgeInsets = UIEdgeInsets(
                vertical: .spacing8,
                horizontal: .spacing16
            ),
            titleHeight: CGFloat? = nil,
            font: UIFont = .heading3,
            imageTitlePadding: ImagePositionPadding? = nil
        ) {
            self.borderWidth = borderWidth

            self.bodyColor = stateStyles[.normal]?.backgroundColor ?? UIColor.primaryBlue.withAlphaComponent(0.4)
            self.borderColor = stateStyles[.normal]?.borderColor
            self.textColor = stateStyles[.normal]?.textColor ?? .primaryBlue

            self.highlightedBodyColor = stateStyles[.highlighted]?.backgroundColor
            self.highlightedTextColor = stateStyles[.highlighted]?.textColor

            self.disabledBodyColor = stateStyles[.disabled]?.backgroundColor
            self.disabledBorderColor = stateStyles[.disabled]?.borderColor
            self.disabledTextColor = stateStyles[.disabled]?.textColor
            
            self.selectedBorderColor = stateStyles[.selected]?.borderColor

            self.margins = margins
            self.titleHeight = titleHeight
            self.font = font
//            self.imageTitlePadding = imageTitlePadding
        }

        func backgroundColor(forState state: UIControl.State) -> UIColor? {
            switch state {
            case .disabled:
                return disabledBodyColor
            default:
                return bodyColor
            }
        }

        func borderColor(forState state: UIControl.State) -> CGColor? {
            switch state {
            case .disabled:
                return disabledBorderColor?.cgColor
            case .selected:
                return selectedBorderColor != nil ? selectedBorderColor?.cgColor : borderColor?.cgColor
            default:
                return borderColor?.cgColor
            }
        }

        /// Given an existing style, this helps to create a new one overriding some of the values of the original style
        /// This method is intended for styles for concrete cases rather than default styles like `callToAction`
        public func overrideStyle(
            bodyColor: UIColor? = nil,
            borderWidth: CGFloat? = nil,
            borderColor: UIColor? = nil,
            textColor: UIColor? = nil,
            disabledBodyColor: UIColor? = nil,
            disabledBorderColor: UIColor? = nil,
            highlightedBodyColor: UIColor? = nil,
            highlightedTextColor: UIColor? = nil,
            disabledTextColor: UIColor? = nil,
            margins: UIEdgeInsets? = nil,
            font: UIFont? = nil,
            selectedBorderColor: UIColor? = nil
        ) -> Style {
            Style(
                bodyColor: bodyColor ?? self.bodyColor,
                borderWidth: borderWidth ?? self.borderWidth,
                borderColor: borderColor ?? self.borderColor,
                textColor: textColor ?? self.textColor,
                disabledBodyColor: disabledBodyColor ?? self.disabledBodyColor,
                disabledBorderColor: disabledBorderColor ?? self.disabledBorderColor,
                highlightedBodyColor: highlightedBodyColor ?? self.highlightedBodyColor,
                highlightedTextColor: highlightedTextColor ?? self.highlightedTextColor,
                disabledTextColor: disabledTextColor ?? self.disabledTextColor,
                margins: margins ?? self.margins,
                titleHeight: self.titleHeight,
                font: font ?? self.font,
                selectedBorderColor: selectedBorderColor ?? self.selectedBorderColor
            )
        }

        // MARK: - Size dependant methods

        func paddings(forSize size: Size) -> UIEdgeInsets {
            switch size {
            case .normal: return UIEdgeInsets(vertical: .spacing16 - .spacing2, horizontal: 0)
            case .small: return .zero
            case .medium:
                return UIEdgeInsets(vertical: .spacing16 - .spacing2, horizontal: 40)
            }
        }

        func font(forSize size: Size) -> UIFont {
            switch size {
            case .normal: return font
            case .medium: return font
            case .small: return font
            }
        }

    }
}

// MARK: - Styles
public extension Button.Style {
    
    static var `default`: Button.Style {
        Button.Style(
            borderWidth: 2.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: .bgSecondary,
                    borderColor: .primaryBlue
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: .primaryBlue
                )
            ],
            titleHeight: .spacing24
        )
    }
    
    static var plain: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(vertical: 2,
                                  horizontal: 0),
            titleHeight: .spacing24
        )
    }
    static func leftImageText(with imageTitlePadding: ImagePositionPadding) -> Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(vertical: 2,
                                  horizontal: 0),
            titleHeight: .spacing24,
            imageTitlePadding: imageTitlePadding
        )
    }
    
    static func rightImageText(with imageTitlePadding: ImagePositionPadding) -> Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(vertical: 2,
                                  horizontal: 0),
            titleHeight: .spacing24,
            imageTitlePadding: imageTitlePadding
        )
    }
    
    static var box: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .black30,
                            backgroundColor: .white,
                            borderColor: .black85
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .black30,
                            backgroundColor: .white,
                            borderColor: .black85
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .black30.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .black85
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 6,
                                           horizontal: 20),
                     titleHeight: 20,
                     font: .body1)
    }
    
    // MARK: - primary buttons
    
    static var primaryBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryGreen: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: DeviceType.isSmallerDevice ? 20 : 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryOrange: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryRed: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryraspberry: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .raspberry,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .raspberry,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .raspberry.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    // MARK: - primary buttons with white background
    
    static var primaryBlueLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .primaryBlue.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryGreenLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .green.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .green.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryOrangeLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .orange.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .orange.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var primaryRedLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .red.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .red.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static func style(with style: Button.Style, margins: UIEdgeInsets) -> Button.Style {
        let style = Button.Style(borderWidth: 1,
                                 stateStyles: [
                                    .normal: Button.StateStyle(
                                        textColor: style.textColor,
                                        backgroundColor: .white,
                                        borderColor: style.borderColor
                                    ),
                                    .highlighted: Button.StateStyle(
                                        textColor: style.textColor,
                                        backgroundColor: .white,
                                        borderColor: style.borderColor
                                    ),
                                    .disabled: Button.StateStyle(
                                        textColor: style.textColor.withAlphaComponent(0.4),
                                        backgroundColor: .white,
                                        borderColor: style.borderColor?.withAlphaComponent(0.4)
                                    )
                                 ],
                                 margins: margins,
                                 titleHeight: 26,
                                 font: .heading3)
        
        return style
    }
    
    static var primaryRedLightWithoutMargins: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .red.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .red.withAlphaComponent(0.4)
                        )
                     ],
                     titleHeight: 26,
                     font: .heading3)
    }

    // MARK: - secondary buttons
    
    static var secondaryBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryBlueLessHzSpace: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 16),
                     titleHeight: .spacing24,
                     font: .heading4)
    }

    static var secondaryGreen: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryOrange: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryRed: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    // MARK: - secondary buttons with white background
    
    static var secondaryBlueLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .primaryBlue.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryGreenLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .green.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .green.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryOrangeLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .orange.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .orange.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    static var secondaryRedLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .red.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .red.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 12,
                                           horizontal: 40),
                     titleHeight: .spacing24,
                     font: .heading4)
    }
    
    // MARK: - tertiary buttons
    
    static var tertiaryBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryBlueSmall: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 6,
                                           horizontal: 16),
                     titleHeight: .spacing20,
                     font: .heading5)
    }

    static var tertiaryGreen: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .green.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryDarkMint: Button.Style {
        Button.Style(borderWidth: 0,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .darkMint,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .darkMint,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .darkMint.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 6,
                                           horizontal: 12),
                     titleHeight: .spacing20,
                     font: .heading5)
    }

    static var tertiaryOrange: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryOrangeSmall: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .orange.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 6,
                                           horizontal: 16),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryRed: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .red.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryBlack30: Button.Style {
        Button.Style(borderWidth: 0,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .black30,
                            backgroundColor: .black95,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .black30,
                            backgroundColor: .black95,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .black30,
                            backgroundColor: .black95.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 8,
                                           horizontal: 1),
                     titleHeight: .spacing16,
                     font: .caption1)
    }
    
    // MARK: - tertiary buttons with white background
    
    static var tertiaryBlueLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .primaryBlue.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryBlueLight16: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .primaryBlue.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 6,
                                           horizontal: 16),
                     titleHeight: .spacing16,
                     font: .heading5)
    }
    
    static var tertiaryGreenLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .green
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .green.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .green.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                    font: .heading5)
    }
    
    static var tertiaryOrangeLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .orange
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .orange.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .orange.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryRedLight: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .red
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .red.withAlphaComponent(0.4),
                            backgroundColor: .white,
                            borderColor: .red.withAlphaComponent(0.4)
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 10,
                                           horizontal: 40),
                     titleHeight: .spacing20,
                     font: .heading5)
    }

    // MARK: - helper buttons
    
    static var helperBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .white,
                            backgroundColor: .primaryBlue.withAlphaComponent(0.4),
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: .spacing6,
                                           horizontal: .spacing16),
                     titleHeight: .spacing20,
                     font: .heading5)
    }
    
    static var tertiaryHelperBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .primaryBlue
                        )
                     ],
                     margins: UIEdgeInsets(vertical: .spacing6,
                                           horizontal: .spacing16),
                     titleHeight: .spacing20,
                     font: .heading5)
    }

    // MARK: - flat button styles
    
    static func flat(with textColor: UIColor) -> Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: textColor,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: textColor,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: textColor.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: .zero,
                     titleHeight: 20,
                     font: .heading5)
    }
    
    static var flatBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .white,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: .zero,
                     titleHeight: 26,
                     font: .heading3)
    }
    
    static var textBlue: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .selected: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .primaryBlue,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .primaryBlue.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: .zero,
                     titleHeight: 24,
                     font: .heading4)
    }
    
    static var flatGreen: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .white,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .green,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .green.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: UIEdgeInsets(vertical: 14,
                                           horizontal: 40),
                     titleHeight: 26,
                    font: .heading3)
    }

    static var flatOrange: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .white,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .orange,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .orange.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: .zero,
                     titleHeight: 26,
                     font: .heading3)
    }

    static var flatRed: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .white,
                            borderColor: .clear
                        ),
                        .highlighted: Button.StateStyle(
                            textColor: .red,
                            backgroundColor: .clear,
                            borderColor: .clear
                        ),
                        .disabled: Button.StateStyle(
                            textColor: .red.withAlphaComponent(0.4),
                            backgroundColor: .clear,
                            borderColor: .clear
                        )
                     ],
                     margins: .zero,
                     titleHeight: 26,
                     font: .heading3)
    }

    static var link: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: .clear,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.primaryBlue.withAlphaComponent(0.4),
                    backgroundColor: nil,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing4,
                horizontal: 0
            ),
            font: .heading5
        )
    }
    
    static var linkWhite: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .white,
                    backgroundColor: .clear,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.white.withAlphaComponent(0.4),
                    backgroundColor: nil,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: .white,
                    backgroundColor: nil,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing4,
                horizontal: 0
            ),
            font: .body1
        )
    }
    
    static var linkOrange: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .orange,
                    backgroundColor: .clear,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.orange,
                    backgroundColor: nil,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing4,
                horizontal: 0
            ),
            font: .heading5
        )
    }
    
    static var linkOrangeRegular: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .orange,
                    backgroundColor: .clear,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.orange,
                    backgroundColor: nil,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: .textDisabled,
                    backgroundColor: nil,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing4,
                horizontal: 0
            ),
            font: .body1
        )
    }
    
    static var linkRed: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .red,
                    backgroundColor: .clear,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.red,
                    backgroundColor: nil,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: .red,
                    backgroundColor: nil,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: .heading4
        )
    }
    
    static var icon: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .clear,
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .highlighted: Button.StateStyle(
                    textColor: nil,
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .disabled: Button.StateStyle(
                    textColor: .clear,
                    backgroundColor: .clear,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: .title1
        )
    }
        
    static var border: Button.Style {
        Button.Style(
            borderWidth: 1,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: .bgSecondary,
                    borderColor: .separatorColour
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: UIColor.bgSecondary.withAlphaComponent(0.4),
                    borderColor: UIColor.separatorColour.withAlphaComponent(0.4)
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: DefaultFontProvider().font(ofSize: 13, weight: .regular)
        )
    }
    
    static var borderWhite: Button.Style {
        Button.Style(
            borderWidth: 1,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .white,
                    backgroundColor: .clear,
                    borderColor: .white
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.white,
                    backgroundColor: UIColor.clear,
                    borderColor: UIColor.white.withAlphaComponent(0.4)
                )
            ])
    }
    
    static var radio: Button.Style {
        Button.Style(
            borderWidth: 0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: .clear,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: DefaultFontProvider().font(ofSize: 16, weight: .regular)
        )
    }
    
    static var checkBox: Button.Style {
        Button.Style(
            borderWidth: 0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: .clear,
                    borderColor: .clear
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor(hex: "353535"),
                    backgroundColor: .clear,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: DefaultFontProvider().font(ofSize: 16, weight: .regular)
        )
    }
        
    static var tag: Button.Style {
        Button.Style(
            borderWidth: 1.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .textPrimary,
                    backgroundColor: .bgSecondary,
                    borderColor: .separatorColour
                ),
                .highlighted: Button.StateStyle(
                    textColor: .textPrimary,
                    backgroundColor: UIColor.bgSecondary.withAlphaComponent(0.4),
                    borderColor: .separatorColour
                ),
                .selected: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: UIColor.primaryBlue.withAlphaComponent(0.9),
                    borderColor: .primaryBlue
                ),
                .disabled: Button.StateStyle(
                    textColor: nil,
                    backgroundColor: UIColor.separatorColour.withAlphaComponent(0.4),
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing4,
                horizontal: .spacing16
            ),
            font: .heading5
        )
    }
    
    static var tagPrimary: Button.Style {
        Button.Style(
            borderWidth: 1.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .textPrimary,
                    backgroundColor: .bgSecondary,
                    borderColor: .separatorColour
                ),
                .highlighted: Button.StateStyle(
                    textColor: .textPrimary,
                    backgroundColor: UIColor.bgSecondary.withAlphaComponent(0.4),
                    borderColor: .separatorColour
                ),
                .selected: Button.StateStyle(
                    textColor: .primaryBlue,
                    backgroundColor: UIColor.primaryBlue.withAlphaComponent(0.9),
                    borderColor: .primaryBlue
                ),
                .disabled: Button.StateStyle(
                    textColor: nil,
                    backgroundColor: UIColor.separatorColour.withAlphaComponent(0.4),
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing6,
                horizontal: .spacing16
            ),
            font: .heading5
        )
    }
    
    static var stepTickIcon: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .clear,
                    backgroundColor: .primaryBlue,
                    borderColor: .clear
                ),
                .highlighted: Button.StateStyle(
                    textColor: nil,
                    backgroundColor: UIColor.primaryBlue.withAlphaComponent(0.4),
                    borderColor: .clear
                ),
                .disabled: Button.StateStyle(
                    textColor: .clear,
                    backgroundColor: .clear,
                    borderColor: .clear
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: .title1
        )
    }

//    static var borderBlueWithAlphaBg: Button.Style {
//        Button.Style(
//            borderWidth: 2.0,
//            stateStyles: [
//                .normal: Button.StateStyle(
//                    textColor: .clear,
//                    backgroundColor: UIColor.primaryBlue.withAlphaComponent(0.1),
//                    borderColor: .primaryBlue
//                ),
//                .highlighted: Button.StateStyle(
//                    textColor: nil,
//                    backgroundColor: UIColor.primaryBlue.withAlphaComponent(0.1),
//                    borderColor: .primaryBlue
//                ),
//                .disabled: Button.StateStyle(
//                    textColor: .clear,
//                    backgroundColor: UIColor.separatorColour.withAlphaComponent(0.1),
//                    borderColor: .separatorColour
//                )
//            ],
//            margins: UIEdgeInsets(
//                vertical: 0,
//                horizontal: 0
//            ),
//            font: .title1
//        )
//    }

    static var disabledStep: Button.Style {
        Button.Style(
            borderWidth: 2.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .separatorColour,
                    backgroundColor: .white,
                    borderColor: .separatorColour
                ),
                .highlighted: Button.StateStyle(
                    textColor: .separatorColour,
                    backgroundColor: .white,
                    borderColor: .separatorColour
                ),
                .disabled: Button.StateStyle(
                    textColor: .separatorColour,
                    backgroundColor: .white,
                    borderColor: .separatorColour
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: 0
            ),
            font: .title1
        )
    }

    static var ctaWithheading5: Button.Style {
        Button.Style(
            borderWidth: 0.0,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .white,
                    backgroundColor: .primaryBlue,
                    borderColor: nil
                ),
                .highlighted: Button.StateStyle(
                    textColor: .white,
                    backgroundColor: .primaryBlue,
                    borderColor: nil
                ),
                .disabled: Button.StateStyle(
                    textColor: nil,
                    backgroundColor: .clear,
                    borderColor: nil
                )
            ],
            margins: UIEdgeInsets(
                vertical: 0,
                horizontal: .spacing12
            ),
            font: .heading5
        )
    }
    static var borderRed: Button.Style {
        Button.Style(
            borderWidth: 1,
            stateStyles: [
                .normal: Button.StateStyle(
                    textColor: .textCritical,
                    backgroundColor: .white,
                    borderColor: .textCritical
                ),
                .highlighted: Button.StateStyle(
                    textColor: UIColor.textCritical,
                    backgroundColor: UIColor.white,
                    borderColor: UIColor.textCritical.withAlphaComponent(0.4)
                )
            ],
            margins: UIEdgeInsets(
                vertical: .spacing8,
                horizontal: .spacing12
            )
        )
    }
    
    static var selectable: Button.Style {
        Button.Style(borderWidth: 1,
                     stateStyles: [
                        .normal: Button.StateStyle(textColor: .textPrimary,
                                                   backgroundColor: .white,
                                                   borderColor: .black85),
                        .highlighted: Button.StateStyle(textColor: .textPrimary,
                                                        backgroundColor: .white,
                                                        borderColor: .black85),
                        .selected: Button.StateStyle(textColor: .primaryBlue,
                                                     backgroundColor: .primaryBlue.withAlphaComponent(0.1),
                                                     borderColor: .primaryBlue)
                     ],
                     margins: UIEdgeInsets(vertical: .spacing6,
                                           horizontal: .spacing12))
    }
}

extension UIControl.State: Hashable {}
// swiftlint:disable:this file_length
