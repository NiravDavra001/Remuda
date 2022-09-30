//
//  ViewContactInfoTableViewCell.swift
//  remuda
//
//  Created by mac on 23/04/21.
//

import UIKit
protocol ViewContactInfoTableViewCellDelegate {
    func showContactInfo(indexPath: IndexPath)
}

class ViewContactInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var btnHideView: UIView!
    @IBOutlet var hideContactInfo: UIButton!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var btnContactInfo: UIButton!
    @IBOutlet weak var contactView: UIView!
    
    @IBOutlet weak var imguserProfile: UIImageView!
    @IBOutlet weak var lblTItleInfo: UILabel!
    
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    var indexPath = IndexPath()
    
    
    var delegate : ViewContactInfoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblContactNo.font  = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblEmail.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblAddress.font  = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        
        lblContactNumber.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblEmailAddress.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblLocation.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        btnContactInfo.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        hideContactInfo.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imguserProfile.setRoundedView()
        contactView.setBorder(1, .button_border_color, 5)
        btnContactInfo.setUpCornerRadius(5)
        hideContactInfo.setUpCornerRadius(5)
    }

    @IBAction func onTapContactInfo(_ sender: Any) {
        mainStackView.setBorder(1, .button_border_color, 5)
        delegate?.showContactInfo(indexPath: self.indexPath)
    }
    @IBAction func onTapHideContactInfo(_ sender: UIButton) {
        delegate?.showContactInfo(indexPath: self.indexPath)
    }
    
    
}

