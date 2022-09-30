//
//  HorseDetailsCollectionViewCell.swift
//  remuda
//
//  Created by mac on 12/04/21.
//

import UIKit

class HorseDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var horseImageView: UIImageView!
    @IBOutlet weak var premiumView: UIView!
    @IBOutlet weak var lblPremium: UILabel!
    @IBOutlet weak var lblHorsebreed: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblShares: UILabel!
    @IBOutlet weak var shadowView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI(){
//        cell_tags_color
        self.shadowView.setMarketPlaceSavedCellGradient()
        premiumView.backgroundColor = .cell_tags_color
        lblPremium.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_10))
        lblHorsebreed.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPrice.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblShares.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentView.setUpCornerRadius(10)
        premiumView.setRoundedView()
            
    }

}
