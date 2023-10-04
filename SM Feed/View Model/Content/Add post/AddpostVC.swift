//
//  AddpostVC.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit

protocol AddpostDelegate {
    func postAdded()
}

class AddpostVC: UIViewController {
    
    @IBOutlet weak var postField: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    
    private var imagePicker = UIImagePickerController()
    var postImage: UIImage?
    
    var viewModel: AddpostVM!
    var delegate: AddpostDelegate? = nil
    var postItem = UIBarButtonItem()
    var discardItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = AddpostVM(view: self)
        self.configureNavigationItems()
        self.configUserImage()
    }
    
    
    private func configureNavigationItems() {
        self.postItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postAction))
        self.postItem.tintColor = .darkGray
        
        self.discardItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(discardAction))
        self.discardItem.tintColor = .darkGray
        
        self.navigationItem.rightBarButtonItems = [postItem]
        self.navigationItem.leftBarButtonItems = [discardItem]
    }
    
    @objc private func postAction() {
        if self.postImage == nil {
            self.viewModel.uploadPost(nil)
        } else {
            self.viewModel.uploadImage()
        }
    }
    
    @objc private func discardAction() {
        self.dismiss(animated: true)
    }
    
    func successAddPost() {
        self.dismiss(animated: true) {
            guard let delegate = self.delegate else {return}
            delegate.postAdded()
        }
    }
    
    private func configUserImage() {
        let guster = UITapGestureRecognizer(target: self, action: #selector(userImageAction))
        self.imgView.addGestureRecognizer(guster)
        self.imgView.isUserInteractionEnabled = true
    }
    @objc func userImageAction() {
        self.chooseImageAction()
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
}
