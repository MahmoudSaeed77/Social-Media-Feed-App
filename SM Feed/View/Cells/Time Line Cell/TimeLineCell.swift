//
//  TimeLineCell.swift
//  SM Feed
//
//  Created by imac on 03/10/2023.
//

import UIKit
import Kingfisher

protocol TimeLineCellDelegate {
    func reactPostAction(index: Int)
}

class TimeLineCell: UITableViewCell {
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var verifiedImgView: UIImageView!
    
    @IBOutlet weak var userLbl: UILabel!
    
    @IBOutlet weak var postTimeLbl: UILabel!
    
    @IBOutlet weak var captionLbl: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var reactImgView: UIImageView!
    
    
    
    var delegate: TimeLineCellDelegate? = nil
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(data: TimeLineModel, delegate: TimeLineCellDelegate, index: Int) {
        self.delegate = delegate
        self.index = index
        self.userImgView.loadImageWithIndicator(url: data.user?.profileImageUrl ?? "")
        self.usernameLbl.text = data.user?.username ?? ""
        self.userLbl.text = "@\(data.user?.username?.filter({!$0.isWhitespace}) ?? "")"
        
        let calendar = Calendar.current
        let currentDate = Date()
        let pastDate = data.date ?? Date()
        let minutesAgo = calendar.dateComponents([.minute], from: pastDate, to: currentDate).minute ?? 0
        
        self.postTimeLbl.text = ". \(minutesAgo)m"
        self.captionLbl.isHidden = data.caption?.isEmpty ?? true
        self.postImageView.isHidden = data.imageUrl?.isEmpty ?? true
        self.captionLbl.text = data.caption ?? ""
        self.postImageView.loadImageWithIndicator(url: data.imageUrl ?? "")
    }
    
    @IBAction func reactAction(_ sender: UIButton) {
        guard let delegate = self.delegate, let index = self.index else {return}
        delegate.reactPostAction(index: index)
    }
}
