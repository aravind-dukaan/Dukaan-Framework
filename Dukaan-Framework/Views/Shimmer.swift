//
//  Shimmer.swift
//  Dukaan
//
//  Created by Raja Earla on 04/06/21.
//

import Foundation
import UIKit

public class Shimmer {
    public init() {}
    public func startShining(_ view: UIView) {
        view.layoutIfNeeded()
        animate(view: view, start: true)
    }
    
    public func stopShining(_ view: UIView) {
        animate(view: view, start: false)
    }
    
    public func startSmartShining(_ view: UIView) {
        addLoader(view, start: true)
    }
    
    public func stopSmartShining(_ view: UIView) {
        addLoader(view, start: false)
    }
    
    private func addLoader(_ view: UIView, start: Bool) {
        view.layoutIfNeeded()
        for subView in view.subviews {
            animate(view: subView, start: start)
        }
    }
    
    private func animate(view: UIView, start: Bool) {
        if start {
            // 1. Add Color Layer
            let colorLayer = CALayer()
            colorLayer.backgroundColor = UIColor(white: 0.82, alpha: 1).cgColor
            colorLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            colorLayer.name = "colorLayer"
            view.layer.addSublayer(colorLayer)
            view.autoresizesSubviews = true
            view.clipsToBounds = true
            
            // 2. Add loader Layer
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(white: 0.82, alpha: 1).cgColor,
                                    UIColor(white: 0.86, alpha: 1).cgColor,
                                    UIColor(white: 0.82, alpha: 1).cgColor]
            gradientLayer.locations = [0, 0.4, 0.8, 1]
            gradientLayer.name = "loaderLayer"
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            view.layer.addSublayer(gradientLayer)
            
            // 3. Animate loader layer
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.2
            animation.fromValue = -view.frame.width
            animation.toValue = view.frame.width
            animation.repeatCount = Float.infinity
            gradientLayer.add(animation, forKey: "smartLoader")
        } else {
            if let smartLayers = view.layer.sublayers?.filter({$0.name == "colorLayer" || $0.name == "loaderLayer"}) {
                smartLayers.forEach({$0.removeFromSuperlayer()})
            }
        }
    }
}

extension UIView {
  
  // ->1
  enum Direction: Int {
    case topToBottom = 0
    case bottomToTop
    case leftToRight
    case rightToLeft
  }
  
    func startShimmer(animationSpeed: Float = 1.5, direction: Direction = .leftToRight, repeatCount: Float = MAXFLOAT) {
    
    // Create color  ->2
    let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).cgColor
    let blackColor = UIColor.black.cgColor
    
    // Create a CAGradientLayer  ->3
    let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
    gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
    
    switch direction {
    case .topToBottom:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
      
    case .bottomToTop:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
      
    case .leftToRight:
      gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.4)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      
    case .rightToLeft:
      gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
    }
    
        gradientLayer.locations = [0.2, 0.5, 0.50, 0.55, 0.7] //   [0.35, 0.50, 0.65]
    self.layer.mask = gradientLayer
    
    // Add animation over gradient Layer  ->4
    CATransaction.begin()
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [0.0, 0.1, 0.2]
    animation.toValue = [0.8, 0.9, 1.0]
    animation.duration = CFTimeInterval(animationSpeed)
    animation.repeatCount = repeatCount
    CATransaction.setCompletionBlock { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.layer.mask = nil
    }
    gradientLayer.add(animation, forKey: "shimmerAnimation")
    CATransaction.commit()
  }
  
  func stopShimmer() {
    self.layer.mask = nil
  }
  
}
