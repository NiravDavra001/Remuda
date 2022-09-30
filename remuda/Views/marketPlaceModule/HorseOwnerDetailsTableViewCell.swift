//
//  HorseOwnerDetailsTableViewCell.swift
//  remuda
//
//  Created by mac on 14/04/21.
//

import UIKit

class HorseOwnerDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHorseBreed: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgUserPic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserCity: UILabel!
    @IBOutlet weak var lblHorseDescription: UILabel!
    @IBOutlet weak var sepraterViewHorseDetails: UIView!
    @IBOutlet weak var sepraterViewUserDetails: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        imgUserPic.setRoundedView()
        
        lblHorseBreed.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_20))
        lblPrice.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblUserCity.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        lblHorseDescription.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
