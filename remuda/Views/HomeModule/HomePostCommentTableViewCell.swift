//
//  HomePostCommentTableViewCell.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//
protocol CommentReplyDelegate {
    func btnCommentReplyAction(indexPath: IndexPath)
}
import UIKit

class HomePostCommentTableViewCell: UITableViewCell {

    @IBOutlet var btnMore: UIButton!
    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblCommentDescription: UILabel!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var btnReplyComment: UIButton!
    @IBOutlet var constaintLeadingMainView: NSLayoutConstraint!
    @IBOutlet var stackViewHeight: UIStackView!
    var indexPath = IndexPath()
    var delegate: CommentReplyDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imgProfilePicture.setRoundedView()
    }
    func setUpUI(){
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblCommentDescription.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblCommentTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        btnReplyComment.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        btnReplyComment.setTitleColor(UIColor(red: 0.413, green: 0.413, blue: 0.413, alpha: 1), for: .normal)
    }
    @IBAction func btnHomeCommentReply(_ sender: UIButton) {
        self.delegate?.btnCommentReplyAction(indexPath: self.indexPath)
    }
}
