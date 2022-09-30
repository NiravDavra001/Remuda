//
//  NewListingCategoryTableViewCell.swift
//  remuda
//
//  Created by Macmini on 26/04/21.
//

import UIKit

class NewListingCategoryTableViewCell: UITableViewCell {

    @IBOutlet var viewCell: UIView!
    @IBOutlet var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        viewCell.backgroundColor = .selectPhoto_background
        lblCategory.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewCell.setUpCornerRadius(5)
    }
}
