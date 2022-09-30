//
//  PhotoVideoSelectionCollectionViewCell.swift
//  remuda
//
//  Created by Macmini on 28/04/21.
//
protocol ListingPhotoSelectionDelegate {
    func btnAddPhotoVideoTapped()
}

import UIKit

class PhotoVideoSelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet var btnAddPhotoVideo: UIButton!
    @IBOutlet var viewForAddphotoVideo: UIView!
    var delegate: ListingPhotoSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnAddPhotoVideo.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnAddPhotoVideo.setTitleColor(.app_lblUserLocation, for: .normal)
        btnAddPhotoVideo.imageView?.tintColor = .app_lblUserLocation
    }
    @IBAction func btnAddPhotoVideo(_ sender: Any) {
        delegate?.btnAddPhotoVideoTapped()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewForAddphotoVideo.setBorder(1, .horseListing_border_gray, 5)
    }
    
}
