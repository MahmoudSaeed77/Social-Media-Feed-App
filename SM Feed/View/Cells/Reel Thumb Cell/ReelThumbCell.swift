//
//  ReelThumbCell.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit

class ReelThumbCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.magenta.cgColor
    }
    
}
