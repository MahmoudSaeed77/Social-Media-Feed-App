//
//  UITextField.swift
//  Reben
//
//  Created by imac on 28/08/2023.
//

import UIKit

extension UITextField {
    func checkMaxLength(maxLength: Int) {
        if (self.text!.count > maxLength) {
            self.deleteBackward()
        }
    }
    
    func setPlaceholderColor(color: UIColor) {
        guard let placeholder = placeholder, let font = font else {
            return
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color, .font: font])
    }
}

extension UITextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
