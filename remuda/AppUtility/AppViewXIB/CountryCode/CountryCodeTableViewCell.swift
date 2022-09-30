//
//  CountryCodeTableViewCell.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import UIKit



class CountryCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var counrtyImage: UIImageView!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    var arrPhoneCode = [ContryCodeModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countryCode.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
        countryName.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
