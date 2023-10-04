//
//  LoginVC.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var viewModel: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginVM(view: self)
    }
    
    
    private func navigateToRegisterController() {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Auth", bundle: .main).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func navigateToHomeController() {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationItem.largeTitleDisplayMode = .always
            self.present(nav, animated: true)
        }
    }
    
    @IBAction func showHidePasswordAction(_ sender: UIButton) {
        self.passwordField.isSecureTextEntry.toggle()
        let eyeImage = UIImage(systemName: "eye.fill")
        let eyedashedImage = UIImage(systemName: "eye.slash.fill")
        sender.setImage(self.passwordField.isSecureTextEntry ? eyedashedImage : eyeImage, for: .normal)
    }
    @IBAction func loginAction(_ sender: UIButton) {
        self.navigateToHomeController()
    }
    @IBAction func registerAction(_ sender: UIButton) {
        self.navigateToRegisterController()
    }
}
