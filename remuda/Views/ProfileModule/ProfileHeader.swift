//
//  ProfileHeader.swift
//  remuda
//
//  Created by Priya Dhola on 10/04/21.
//

protocol SelectImageAlertDelegate {
    func showAlert()
    func tappedStackView()
}

import UIKit
import SDWebImage

class ProfileHeader: UITableViewHeaderFooterView {
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserLocation: UILabel!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var profilePictureTapView: UIView!
    @IBOutlet var tapStackView: UIStackView!
    
    var delegate: SelectImageAlertDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
        let tappedProgilepicture = UITapGestureRecognizer(target: self, action: #selector(self.handleProfileViewTap(_:)))
        profilePictureTapView.addGestureRecognizer(tappedProgilepicture)
        let tappedStackView = UITapGestureRecognizer(target: self, action: #selector(self.handlestackViewTap(_:)))
        tapStackView.addGestureRecognizer(tappedStackView)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.imgProfile.setRoundedView()
        }
    }
    @objc func handleProfileViewTap(_ sender: UITapGestureRecognizer? = nil) {
        self.delegate?.showAlert()
    }
    @objc func handlestackViewTap(_ sender: UITapGestureRecognizer? = nil) {
        self.delegate?.tappedStackView()
    }
    @IBAction func btnEditImage(_ sender: UIButton) {
        self.delegate?.showAlert()
    }
    
    func setUpUI(){
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_20))
        self.lblUserLocation.textColor = .app_lblUserLocation
        self.lblUserLocation.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
    }
}
