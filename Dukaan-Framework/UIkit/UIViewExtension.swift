//
//  UIViewExtensions.swift
//  Dukaan
//
//  Created by Kartik on 28/01/21.
//

import UIKit
import Foundation


public extension UIView {
    convenience init(withAutoLayout autoLayout: Bool) {
        self.init()
        frame = .zero
        translatesAutoresizingMaskIntoConstraints = !autoLayout
    }

    func resetDropShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize = CGSize.zero, radius: CGFloat = 10.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.rasterizationScale = UIScreen.main.scale
    }

    var windowSafeAreaInsets: UIEdgeInsets {
        return UIView.windowSafeAreaInsets
    }

    static var windowSafeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
    
}

public extension UIView {

    func applyShadow(
        apply: Bool = true,
        color: UIColor = UIColor.black,
        offset: CGSize = CGSize(width: 0, height: 1),
        opacity: Float = 0.4, radius: Float = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = apply ? offset : CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = apply ? opacity : 0.0
        self.layer.shadowRadius = apply ? CGFloat(radius) : 0.0
        
    }
    
    // added this generic default shadow for every card in whole app
    func applyGenericShadow(
        apply: Bool = true,
        color: UIColor = UIColor.black,
        offset: CGSize = CGSize(width: 0, height: 1),
        opacity: Float = 0.04, radius: Float = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = apply ? offset : CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = apply ? opacity : 0.0
        self.layer.shadowRadius = apply ? CGFloat(radius) : 0.0
    }
        
    // Button Shadow individual
    func applyButtonShadow(
        apply: Bool = true,
        color: UIColor = UIColor.black,
        offset: CGSize = CGSize(width: 0, height: 3),
        opacity: Float = 0.2, radius: Float = 4) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = apply ? offset : CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = apply ? opacity : 0.0
        self.layer.shadowRadius = apply ? CGFloat(radius) : 0.0
    }
    
    func applyGlow(apply: Bool, color: UIColor) {
        self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = apply ? 0.4 : 0.0
        self.layer.shadowRadius = apply ? 10.0 : 0.0
        self.layer.masksToBounds = false
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let radii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: radii)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.backgroundColor = backgroundColor?.cgColor
        layer.mask = mask
    }

}

extension UIView {
    
    func roundAll(radius: CGFloat = 5) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,
                                        .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundTop(radius: CGFloat = 5) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    func roundBottom(radius: CGFloat = 5) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundCorners() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner,
                                        .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func copyView() -> UIView {
        self.isHidden = false // The copy not works if is hidden, just prevention
        return self.snapshotView(afterScreenUpdates: true) ?? View()
    }
}

extension UIView {
    func applyBorder(with color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func removeBorder() {
        layer.borderColor = nil
        layer.borderWidth = 0
    }
    
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }
}

//extension UIView {
//    func showLoader() {
//        Loader.showAdded(to: self, animated: true)
//    }
//
//    func hideLoader() {
//        Loader.hide(for: self, animated: true)
//    }
//}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

//extension UIViewController {
//    func showPremium() {
//        let domainPremiumVC = DomainPremiumViewController()
//        domainPremiumVC.launchSource = .home
//        domainPremiumVC.modalPresentationStyle = .custom
//        domainPremiumVC.hidesBottomBarWhenPushed = true
//        let navgVC = NavigationController(rootViewController: domainPremiumVC)
//        navgVC.modalPresentationStyle = .fullScreen
//        present(navgVC, animated: true, completion: nil)
//    }
//}

extension UIView {
    
    @discardableResult
    func addTapGesture(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(gesture)
        return gesture
    }
}
extension Button {
    func setUnderline() {
        let title = currentTitle ?? (currentAttributedTitle?.string ?? "")
        let textRange = NSRange(location: 0, length: title.count)
        let attributedTitle = NSMutableAttributedString(string: title)

        attributedTitle.addAttribute(.foregroundColor, value: style.textColor, range: textRange)
        let underlinedAttributedTitle = NSMutableAttributedString(string: title)

        let underlineAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: style.textColor
        ]
        underlinedAttributedTitle.addAttributes(underlineAttributes, range: textRange)

        super.setAttributedTitle(underlinedAttributedTitle, for: .normal)
        super.setAttributedTitle(underlinedAttributedTitle, for: .highlighted)
        super.setAttributedTitle(underlinedAttributedTitle, for: .disabled)
    }
}

extension UITableView {
    // set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    func setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size =  header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}
