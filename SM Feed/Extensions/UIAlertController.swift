//
//  UIAlertController.swift
//  Reben
//
//  Created by imac on 07/08/2023.
//

import UIKit

extension UIViewController {
    func alert(message: String, completion: (() -> Void)? = nil)  {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK".localized, style: .destructive) { _ in
            alert.dismiss(animated: true, completion: nil)
            completion?()
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
