//
//  ConfirmAlertPopUpView.swift
//  Dukaan
//
//  Created by Raja Earla on 01/10/21.
//

import UIKit

class ConfirmAlertPopUpView: UIView {

    private lazy var mainView: View = {
        let view = View(frame: .zero)
        view.backgroundColor = .white
        view.roundedCorner(radius: 6)
        return view
    }()
     
    private lazy var titleLabel: Label = {
        let label = Label(style: .heading3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Close Dukaan Plus?"
        label.textColor = .black12
        return label
    }()
    
    private lazy var subTitleLabel: Label = {
        let label = Label(style: .subtitle2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black50
        label.numberOfLines = 0
        label.text = "We recommend you to watch the entire tutorial to earn commisions."
        return label
    }()
    
    private lazy var closeButton: Button = {
        let button = Button(style: .icon)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.setImage(R.image.closeIcon(), for: .normal)
        button.tintColor = .black30
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
        
    private lazy var noButton: Button = {
        let button = Button(style: .flat(with: .black30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("No", for: .normal)
        button.addTarget(self, action: #selector(noAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var yesButton: Button = {
        let button = Button(style: .tertiaryBlueSmall)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Yes", for: .normal)
        button.roundedCorner(radius: 6)
        button.addTarget(self, action: #selector(yesAction), for: .touchUpInside)
        return button
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var subTitle: String = "" {
        didSet {
            subTitleLabel.text = subTitle
        }
    }
    
    var primaryAction: ActionBlock?
    var secondaryAction: ActionBlock?
    var closeAction: ActionBlock?
    
    convenience init(_ title: String, _ subTitle: String) {
        self.init(frame: .zero)
        setup()
        self.title = title
        self.subTitle = subTitle
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}

private extension ConfirmAlertPopUpView {
    func setup() {
        addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subTitleLabel)
        mainView.addSubview(closeButton)
        mainView.addSubview(noButton)
        mainView.addSubview(yesButton)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: .spacing16),
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: .spacing16),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: .spacing8.negate),
        
            closeButton.widthAnchor.constraint(equalToConstant: .spacing24),
            closeButton.heightAnchor.constraint(equalToConstant: .spacing24),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: .spacing16.negate),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .spacing12),
            subTitleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: .spacing16),
            subTitleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: .spacing16.negate),
            
            yesButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: .spacing16),
            yesButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: .spacing16.negate),
            yesButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: .spacing16.negate),
            yesButton.leadingAnchor.constraint(equalTo: noButton.trailingAnchor, constant: .spacing16),
            
            noButton.centerYAnchor.constraint(equalTo: yesButton.centerYAnchor)
        ])
    }
    
    @objc func closeTapped() {
        if let cb = closeAction {
            cb()
        }
    }
    
    @objc func noAction() {
        if let cb = secondaryAction {
            cb()
        }
    }
    
    @objc func yesAction() {
        if let cb = primaryAction {
            cb()
        }
    }
}
