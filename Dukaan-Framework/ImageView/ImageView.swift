//
//  ImageView.swift
//  Dukaan
//
//  Created by Kartik on 29/01/21.
//

import UIKit

class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = .spacing4
    }
    convenience init(_ image: UIImage?) {
        self.init(frame: .zero)
        self.image = image
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
