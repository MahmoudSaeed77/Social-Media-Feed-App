//
//  UIView.swift
//  Reben
//
//  Created by Mahmoud Saeed on 19/07/2023.
//

import UIKit

extension UIView {
    func dropShadowView(shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
class AppView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropShadowView(shadowOpacity: 0.4, shadowRadius: 4)
    }
}
extension UIView {
    func loadXib<T: UIView>(xibName: String, ofType: T.Type, completion: ((T) -> Void)?) {
        if let customView = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? T {
            customView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(customView)
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                customView.topAnchor.constraint(equalTo: self.topAnchor),
                customView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                customView.widthAnchor.constraint(equalTo: self.widthAnchor),
                customView.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
            customView.layoutIfNeeded()
            self.layoutIfNeeded()
            completion?(customView)
        }
    }
}
