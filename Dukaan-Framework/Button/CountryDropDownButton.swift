//
//  CountryDropDownButton.swift
//  Dukaan
//
//  Created by Raja Earla on 15/12/21.
//

import Foundation
import UIKit

public final class CountryDropDownButton: UIControl {
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var countryImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = R.image.indiaFlag()
        return imageView
    }()

    private lazy var label: Label = {
        let label = Label(style: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black12
        label.textAlignment = .center
        return label
    }()
    
    private lazy var downArrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = R.image.bottomArrow()
        return imageView
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var icon: UIImage? {
        didSet {
            countryImageView.image = icon
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(image: UIImage?, text: String) {
        super.init(frame: .zero)
        
        self.setup()
        self.countryImageView.image = image
        self.label.text = text
    }
    
    func setup() {
        
        addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(countryImageView)
        contentView.addSubview(downArrowImageView)

        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            countryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countryImageView.heightAnchor.constraint(equalToConstant: 24),
            countryImageView.widthAnchor.constraint(equalToConstant: 24),
            countryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing4),
            countryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant: .spacing6),
            label.trailingAnchor.constraint(equalTo: downArrowImageView.leadingAnchor, constant: .spacing4.negate),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            downArrowImageView.heightAnchor.constraint(equalToConstant: 16),
            downArrowImageView.widthAnchor.constraint(equalToConstant: 16),
            downArrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            downArrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .spacing2.negate)
        ])
        
        countryImageView.contentMode = .scaleAspectFit

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        super.sendActions(for: .touchUpInside)
        alpha = 0.4
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = 1
    
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.isUserInteractionEnabled = true
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        alpha = 1
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        alpha = 1
    }
}
