//
//  PostsTableViewCell.swift
//  remuda
//
//  Created by Macmini on 13/04/21.
//

import UIKit
protocol UpdateTableviewDataDelegate {
    func updateTableview(index: Int)
    func didPressCommentButton(tag: IndexPath)
    func didPressSavedButton(indexPath: IndexPath)
    func btnLike(indexPath: IndexPath)
    func btnShareAction(indexPath: IndexPath)
}

class PostsTableViewCell: UITableViewCell {

    @IBOutlet var postedUserimage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblPostTextDetail: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var lblCommentCount: UILabel!
    @IBOutlet var lblSaved: UILabel!
    @IBOutlet var lblShare: UILabel!
    @IBOutlet var viewForImageView: UIView!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnSaved: UIButton!
    
    var indexPath = IndexPath()
    var delegate: UpdateTableviewDataDelegate?
    var index: Int!
    let unlikedImage = UIImage(named: "Unlike")
    let likedImage = UIImage(named: "like")
    var isLiked = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func draw(_ rect: CGRect) {
        postedUserimage.setRoundedView()
    }

    func setUpUI(){
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPostTextDetail.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblTime.textColor = .label_bookmarks_postGrey_color
        lblCommentCount.setSemiBold13SizeFont()
        lblSaved.setSemiBold13SizeFont()
        lblShare.setSemiBold13SizeFont()
    }
    
    @IBAction func btnSaved(_ sender: UIButton) {
        delegate?.didPressSavedButton(indexPath: self.indexPath)
    }
    
    @IBAction func btnLike(_ sender: Any) {
    }

}

