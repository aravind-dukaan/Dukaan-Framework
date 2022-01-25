//
//  VerticalImageButton.swift
//  Dukaan
//
//  Created by Kartik on 29/01/21.
//

import Foundation
import UIKit

public final class VerticalImageButton: UIControl {
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: Label = {
        let label = Label(style: .heading5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "4D4D4D")
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
            imageView.image = icon
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(image: UIImage?, text: String) {
        super.init(frame: .zero)
        
        self.setup()
        self.imageView.image = image
        self.label.text = text
    }
    
    func setup() {
        
        addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 36),
            imageView.widthAnchor.constraint(equalToConstant: 36),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .spacing4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFit

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
