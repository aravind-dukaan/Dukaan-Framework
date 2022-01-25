//
//  VerticalPanelView.swift
//  Dukaan
//
//  Created by Kartik on 05/08/21.
//

import Foundation
import UIKit



class VerticalPanelView: UIView {
 
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(views: [UIView], spacing: CGFloat = 0, showSeparator: Bool) {
        stackView.removeArrangedSubviews()
        stackView.spacing = spacing
        if showSeparator {
            for (index, view) in views.enumerated() {
                if index < views.count - 1 {
                    stackView.addArrangedSubview(view)
                    stackView.addArrangedSubview(insertSeparator())
                } else {
                    stackView.addArrangedSubview(view)
                }
            }
            layoutViews()
        } else {
            stackView.addArrangedSubviews(views)
        }
    }

    var separators: [UIView] = []
    
    func insertSeparator() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separatorColour
        separators.append(view)
        return view
    }
    
    func layoutViews() {
        separators.forEach { view in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacing16),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .spacing16.negate),
                view.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
    }
}

private extension VerticalPanelView {
    
    func setup() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
