//
//  OnlineButton.swift
//  Dukaan
//
//  Created by Kartik on 22/03/21.
//

import Foundation
import UIKit

protocol OnlineButtonDelegate: AnyObject {
    func onlineButton(_ onlineButton: OnlineButton, isOn: Bool)
}

class OnlineButton: UIView {
    
    weak var delegate: OnlineButtonDelegate?
    
    private lazy var onlineLabelView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.image = R.image.onlineLabel()
        view.alpha = 0
        return view
    }()
    
    private lazy var offlineLabelView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.image = R.image.offlineLabel()
        view.alpha = 0
        return view
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var circularView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundedCorner(radius: 11)
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var circularViewLeadingConstraint: NSLayoutConstraint!
    var impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var isOn = true
    
    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(_ isOn: Bool) {
        self.isOn = isOn
        UIView.animate(withDuration: 0.3) {
            if isOn {
                self.onlineLabelView.alpha = 1
                self.offlineLabelView.alpha = 0
                self.circularViewLeadingConstraint.constant = 54
                self.circularView.backgroundColor = .primaryBlue
            } else {
                self.onlineLabelView.alpha = 0
                self.offlineLabelView.alpha = 1
                self.circularViewLeadingConstraint.constant = 4
                self.circularView.backgroundColor = .textCritical
            }
//            self.impactGenerator.impactOccurred()
//            self.layoutIfNeeded()
        }
    }
    
    @objc func buttonTapped() {
//        configure(!isOn)
        delegate?.onlineButton(self, isOn: !isOn)
    }
}

private extension OnlineButton {
    func setup() {
        addSubview(bgView)
        bgView.addSubview(onlineLabelView)
        bgView.addSubview(offlineLabelView)
        bgView.addSubview(circularView)
        bgView.addSubview(button)
        
        circularViewLeadingConstraint = circularView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 54)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            onlineLabelView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: .spacing8),
            onlineLabelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            offlineLabelView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -.spacing8),
            offlineLabelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            circularViewLeadingConstraint,
            circularView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: .spacing4),
            circularView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -.spacing4),
            circularView.widthAnchor.constraint(equalTo: circularView.heightAnchor),
            circularView.widthAnchor.constraint(equalToConstant: 22),
            
            button.topAnchor.constraint(equalTo: bgView.topAnchor),
            button.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bgView.bottomAnchor)
        ])
    }
}
