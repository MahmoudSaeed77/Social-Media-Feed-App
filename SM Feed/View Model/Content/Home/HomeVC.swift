//
//  HomeVC.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLineReelsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeVM!
    
    var postItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SM Feed"
        self.viewModel = HomeVM(view: self)
        self.configureTableView()
        self.configureCollection()
        self.configureNavigationItems()
    }
    
    private func configureTableView() {
        self.tableView.register(UINib(nibName: "TimeLineCell", bundle: .main), forCellReuseIdentifier: "TimeLineCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func configureCollection() {
        self.collectionView.register(UINib(nibName: "ReelThumbCell", bundle: .main), forCellWithReuseIdentifier: "ReelThumbCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func configureNavigationItems() {
        self.postItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(postAction))
        self.postItem.tintColor = .darkGray
        self.navigationItem.rightBarButtonItems = [postItem]
    }
    
    private func navigateToAddPostController() {
        let vc = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "AddpostVC") as! AddpostVC
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
    
    @objc private func postAction() {
        self.navigateToAddPostController()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
