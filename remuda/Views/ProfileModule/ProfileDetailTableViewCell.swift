//
//  ProfileDetailTableViewCell.swift
//  remuda
//
//  Created by Priya Dhola on 10/04/21.
//

import UIKit

class ProfileDetailTableViewCell: UITableViewCell {

    @IBOutlet var lblProfileCellData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        lblProfileCellData.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
}
