//
//  MarketPlaceListingTableViewCell.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//
protocol MarketplaceListingsActionDelegate {
    func btnListingsAction(indexPath: IndexPath)
}

import UIKit

class MarketPlaceListingTableViewCell: UITableViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblListingTitle: UILabel!
    @IBOutlet var lblListingPrice: UILabel!
    @IBOutlet var lblListingUploadedTime: UILabel!
    @IBOutlet var lblListingShare: UILabel!
    @IBOutlet var btnListing: UIButton!
    var delegate: MarketplaceListingsActionDelegate?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.imgView.setUpCornerRadius(10)
        self.btnListing.setUpCornerRadius(5)
    }
    
    func setUpUI(){
        self.lblListingTitle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.lblListingPrice.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.lblListingUploadedTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblListingUploadedTime.textColor = .app_lblUserLocation
        self.lblListingShare.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblListingShare.textColor = .app_lblUserLocation
        self.btnListing.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.btnListing.setTitleColor(.white, for: .normal)
        self.btnListing.backgroundColor = .app_green_color
    }
    @IBAction func btnListingsActions(_ sender: Any) {
        self.delegate?.btnListingsAction(indexPath: self.indexPath)
    }
}
