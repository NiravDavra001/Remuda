//
//  CommentReplyTableViewCell.swift
//  remuda
//
//  Created by Macmini on 23/04/21.
//

import UIKit

class CommentReplyTableViewCell: UITableViewCell {

    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblCommentDescription: UILabel!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var btnReplyComment: UIButton!
    @IBOutlet var constaintLeadingMainView: NSLayoutConstraint!
    @IBOutlet var btnHomeCommentReply: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblCommentDescription.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblCommentTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        btnReplyComment.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        btnReplyComment.setTitleColor(UIColor(red: 0.413, green: 0.413, blue: 0.413, alpha: 1), for: .normal)
    }
}
