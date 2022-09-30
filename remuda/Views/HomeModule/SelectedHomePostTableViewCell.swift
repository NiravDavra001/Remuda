//
//  SelectedHomePostTableViewCell.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//

import UIKit

class SelectedHomePostTableViewCell: UITableViewCell {
    
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
    @IBOutlet var btnComment: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.postedUserimage.setRoundedView()
    }
    
    func setUpUI(){
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPostTextDetail.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblTime.textColor = .label_bookmarks_postGrey_color
        lblLikeCount.setSemiBold13SizeFont()
        lblCommentCount.setSemiBold13SizeFont()
        lblSaved.setSemiBold13SizeFont()
        lblShare.setSemiBold13SizeFont()
    }
}
