//
//  NewListingPhotosCollectionViewCell.swift
//  remuda
//
//  Created by Macmini on 03/05/21.
//

import UIKit

class NewListingPhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imgHorseListing: UIImageView!
    @IBOutlet var viewForAddphotoVideo: UIView!
    @IBOutlet var viewClose: UIView!
    @IBOutlet var btnRemove: UIButton!
    var index: Int?
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnRemove(_ sender: UIButton) {
//        indexPath = IndexPath(row: sender.tag, section: 0)
//        print("indextPath row is:",self.indexPath.row)
//        delegate?.btnRemoveTapped(indexPath: self.indexPath)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imgHorseListing.setUpCornerRadius(5)
        viewForAddphotoVideo.setBorder(1, .horseListing_border_gray, 5)
        viewClose.setRoundedView()
    }

}
