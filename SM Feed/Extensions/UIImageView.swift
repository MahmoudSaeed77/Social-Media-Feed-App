//
//  UIImageView.swift
//  Reben
//
//  Created by imac on 08/08/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImageWithIndicator(url: String) {
        self.kf.indicator?.startAnimatingView()
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), placeholder: nil, options: nil) { result in
            self.kf.indicator?.stopAnimatingView()
        }
    }
}
