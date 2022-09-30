//
//  PreviousLocationTableViewCell.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//

import UIKit

class PreviousLocationTableViewCell: UITableViewCell {

    @IBOutlet var ingLocationIcon: UIImageView!
    @IBOutlet var lblLocationName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        lblLocationName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblLocationName.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
    }
}
