//
//  HorseDetailsTableViewCell.swift
//  remuda
//
//  Created by mac on 14/04/21.
//

import UIKit

class HorseDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTItle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet var sepratorView: UIView!
    @IBOutlet var btnPedigree: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTItle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblDetails.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTItle.textColor = .button_gray_color
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitleAndDetails(title : String , details : String){
        lblTItle.text = title
        lblDetails.text = details
    }
    
}
