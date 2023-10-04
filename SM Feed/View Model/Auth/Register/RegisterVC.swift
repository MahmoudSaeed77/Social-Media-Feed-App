//
//  RegisterVC.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    var viewModel: RegisterVM!
    private var imagePicker = UIImagePickerController()
    var editedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RegisterVM(view: self)
        self.title = "Register new account"
        self.configureTappingProfileimageView()
    }
    
    private func configureTappingProfileimageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTappedAction))
        self.profileImgView.addGestureRecognizer(gesture)
        self.profileImgView.isUserInteractionEnabled = true
    }
    
    @objc private func profileImageTappedAction() {
        self.chooseImageAction()
    }
    
    func navigateToHomeController() {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationItem.largeTitleDisplayMode = .always
            self.present(nav, animated: true)
        }
    }
    
    private func chooseImageAction() {
        // upload new image
        let alert = UIAlertController(title: "Choose type", message: "", preferredStyle: .actionSheet)
        
        let saved = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let library = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(saved)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showHidePasswordAction(_ sender: UIButton) {
        self.passwordField.isSecureTextEntry.toggle()
        let eyeImage = UIImage(systemName: "eye.fill")
        let eyedashedImage = UIImage(systemName: "eye.slash.fill")
        sender.setImage(self.passwordField.isSecureTextEntry ? eyedashedImage : eyeImage, for: .normal)
    }
    @IBAction func registerAction(_ sender: UIButton) {
        guard self.usernameField.text?.isEmpty == false, self.emailField.text?.isEmpty == false, self.passwordField.text?.isEmpty == false else {return}
        self.viewModel.registerUser(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
    }
    
}
