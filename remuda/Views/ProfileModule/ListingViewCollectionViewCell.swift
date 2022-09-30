//
//  ListingViewCollectionViewCell.swift
//  remuda
//
//  Created by Macmini on 14/04/21.
//
protocol UnSaveListingDelegate {
    func didPressUnsave(indexPath: IndexPath)
}
import UIKit

class ListingViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imgDetails: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var listSavedView: UIView!
    @IBOutlet var racingView: UIView!
    @IBOutlet var lblHourseName: UILabel!
    @IBOutlet var lblHoursePriice: UILabel!
    @IBOutlet var lblPostUploadedTime: UILabel!
    @IBOutlet var lblPostShare: UILabel!
    @IBOutlet var lblTopRacing: UILabel!
    @IBOutlet var shadowView: UILabel!
    @IBOutlet var btnSaveBookmark: UIButton!
    var indexPath = IndexPath()
    var delegate: UnSaveListingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.mainView.setUpCornerRadius(10)
        self.racingView.setRoundedView()
        self.listSavedView.roundCorners(corners: [.topRight,.bottomLeft], radius: 10)
    }
    
    private func setUpUI(){
        self.shadowView.setMarketPlaceSavedCellGradient()
        self.btnSaveBookmark.tintColor = .postLike_red_color
        self.lblHourseName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.lblHoursePriice.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.lblPostUploadedTime.font = UIFont(name: FontName.RRegular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblPostShare.font = UIFont(name: FontName.RRegular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblTopRacing.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblPostUploadedTime.textColor = .profile_listing_gray
        self.lblPostShare.textColor = .profile_listing_gray
        self.racingView.layer.backgroundColor = UIColor.profile_listing_topView_color
    }

    @IBAction func btnUnsaveAction(_ sender: UIButton) {
        self.delegate?.didPressUnsave(indexPath: self.indexPath)
    }
}
