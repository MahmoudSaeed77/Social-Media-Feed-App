//
//  UIButton.swift
//  Reben
//
//  Created by Mahmoud Saeed on 25/07/2023.
//

import UIKit

class AppButton: UIButton {
    let indicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .white
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configFont()
        self.dropShadowView(shadowOpacity: 0.4, shadowRadius: 6)
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    private func configFont() {
//        self.titleLabel?.font = UIFont(name: "Tajawal-Black", size: 18)
    }
}
