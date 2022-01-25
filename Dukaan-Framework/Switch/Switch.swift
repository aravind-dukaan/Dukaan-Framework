//
//  Switch.swift
//  Dukaan
//
//  Created by Kartik on 18/02/21.
//

import Foundation
import UIKit

protocol SwitchDelegate: AnyObject {
    func switchDidChangeValue(toggleSwitch: Switch, value: Bool)
}

class Switch: UIView {

//    var button: UIButton!
    var circleView: UIView!
    var clickButton: UIButton!
    var buttonLeftConstraint: NSLayoutConstraint!
    var buttonRightConstraint: NSLayoutConstraint!
    let hapticGenerator = UISelectionFeedbackGenerator()

    weak var delegate: SwitchDelegate?
    
    var isOn: Bool = false {
        didSet {
            animationswitchButton()
        }
    }
    
//    var originalImage: UIImage = R.image.switchIcon()!
//    var selectedImage: UIImage = R.image.switchIcon()!
    var selectedColor: UIColor = UIColor.primaryBlue
    var originalColor: UIColor = UIColor.separatorColour
    
    private var offCenterPosition: CGFloat!
    private var onCenterPosition: CGFloat!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
//        button = UIButton(type: .custom)
        circleView = UIView(frame: .zero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .white
        clickButton = UIButton(type: .custom)
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(circleView)
        addSubview(clickButton)
//        button.translatesAutoresizingMaskIntoConstraints = false
        clickButton.addTarget(self, action: #selector(switchButtonTouch), for: .touchUpInside)
//        button.setImage(originalImage, for: .normal)
//        button.setImage(selectedImage, for: .selected)
//        offCenterPosition = self.bounds.height * 0.1
//        onCenterPosition = self.bounds.width - (self.bounds.height * 0.9)
//        button.imageEdgeInsets = UIEdgeInsets(top: 1,
//                                              leading: 0,
//                                              bottom: 1,
//                                              trailing: 0)
//        if isOn == true {
//            self.button.backgroundColor = selectedColor
//        } else {
//            self.button.backgroundColor = originalColor
//        }
        
        if self.backgroundColor == nil {
            self.backgroundColor = .white
        }
        initLayout()
        animationswitchButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        circleView.layer.cornerRadius = circleView.bounds.height / 2
    }
    
    private func initLayout() {
        circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonLeftConstraint = circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3)
        buttonLeftConstraint.isActive = true
        circleView.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        circleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 1).isActive = true
        buttonRightConstraint = circleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3)
        
        NSLayoutConstraint.activate([
            clickButton.topAnchor.constraint(equalTo: topAnchor),
            clickButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            clickButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            clickButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
//    func setImages(onImage: UIImage?, offImage: UIImage?) {
//            button.setImage(offImage, for: .normal)
//            button.setImage(onImage, for: .selected)
//        }
        
    @objc func switchButtonTouch() {
        isOn = !isOn
        hapticGenerator.selectionChanged()
        animationswitchButton()
        delegate?.switchDidChangeValue(toggleSwitch: self, value: isOn)
    }
    
    func animationswitchButton() {
        if isOn == true {
            // Rotate animation
//            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
//            rotateAnimation.fromValue = -CGFloat(Double.pi)
//            rotateAnimation.toValue = 0.0
//            rotateAnimation.duration = 0.45
//            rotateAnimation.isCumulative = false
//            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            // Translation animation
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
//                self.button.isSelected = true
                self.backgroundColor = .primaryBlue
//                self.buttonLeftConstraint.constant = self.onCenterPosition
                self.buttonLeftConstraint.isActive = false
                self.buttonRightConstraint.isActive = true
                self.layoutIfNeeded()
//                self.button.backgroundColor = self.selectedColor
                }, completion: { (_) -> Void in
//                    self.button.layer.shadowOffset = CGSize(width: 0, height: 0.2)
//                    self.button.layer.shadowOpacity = 0.3
//                    self.button.layer.shadowRadius = self.offCenterPosition
                    self.circleView.layer.cornerRadius = self.circleView.frame.height / 2
//                    self.button.layer.shadowPath = UIBezierPath(roundedRect: self.button.layer.bounds, cornerRadius: self.button.frame.height / 2).cgPath
            })
        } else {
            // Clear Shadow
//            self.button.layer.shadowOffset = CGSize.zero
//            self.button.layer.shadowOpacity = 0
//            self.button.layer.shadowRadius = self.button.frame.height / 2
//            self.button.layer.cornerRadius = self.button.frame.height / 2
//            self.button.layer.shadowPath = nil
            
            // Rotate animation
//            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
//            rotateAnimation.fromValue = 0.0
//            rotateAnimation.toValue = -CGFloat(Double.pi)
//            rotateAnimation.duration = 0.45
//            rotateAnimation.isCumulative = false
//            self.button.layer.add(rotateAnimation, forKey: "rotate")
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
//                self.button.isSelected = false
                self.backgroundColor = .separatorColour
//                self.buttonLeftConstraint.constant = self.offCenterPosition
                self.buttonRightConstraint.isActive = false
                self.buttonLeftConstraint.isActive = true
                self.layoutIfNeeded()
//                self.button.backgroundColor = self.originalColor
                }, completion: { (_) -> Void in
            })
        }
    }
}
