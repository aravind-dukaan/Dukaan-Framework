//
//  VStackTitleActionSubTitleView.swift
//  Dukaan
//
//  Created by Raja Earla on 23/09/21.
//

import UIKit

class VStackTitleActionSubTitleView: UIView {
    private lazy var titleLabel: Label = {
        let label = Label(style: .body1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textPrimary
        label.textAlignment  = .left
        label.lineSpacing(1.19)
        return label
    }()
    
    private lazy var actionButton: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        button.contentMode = .left
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    var titleLabelFont: UIFont = .body1 {
        didSet {
            titleLabel.font = titleLabelFont
        }
    }

    var valueLabelFont: UIFont = .body1 {
        didSet {
            actionButton.titleLabel?.font = valueLabelFont
        }
    }
    var actionBlock: ActionBlock?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ title: String, _ value: String) {
        titleLabel.text = title
        actionButton.setTitle(value, for: .normal)
        actionButton.setUnderline()
    }
}

private extension VStackTitleActionSubTitleView {
    
    func setup() {
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        actionButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    @objc func actionButtonTapped() {
        if let cb = actionBlock {
            cb()
        }
    }
}
