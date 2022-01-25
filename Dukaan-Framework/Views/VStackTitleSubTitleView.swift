//
//  VStackTitleSubTitleView.swift
//  Dukaan
//
//  Created by Raja Earla on 23/09/21.
//

import UIKit

class VStackTitleSubTitleView: UIView {
    private lazy var titleLabel: Label = {
        let label = Label(style: .subtitle3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black12
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: Label = {
        let label = Label(style: .subtitle2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black12
        label.textAlignment  = .left
        return label
    }()
    private var verticalSpacing: CGFloat = .spacing2
    convenience init(_ spacing: CGFloat = .spacing2) {
        self.init(frame: .zero)
        self.verticalSpacing = spacing
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var titleLabelFont: UIFont = .subtitle3 {
        didSet {
            titleLabel.font = titleLabelFont
        }
    }

    var valueLabelFont: UIFont = .subtitle2 {
        didSet {
            valueLabel.font = valueLabelFont
        }
    }
    
    var titleLabelColor: UIColor = .black12 {
        didSet {
            titleLabel.textColor = titleLabelColor
        }
    }

    var valueLabelColor: UIColor = .black12 {
        didSet {
            valueLabel.textColor = valueLabelColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ title: String, _ value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}

private extension VStackTitleSubTitleView {
    
    func setup() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalSpacing),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        valueLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
