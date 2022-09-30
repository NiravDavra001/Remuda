//
//  SupportListTableViewCell.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import UIKit

class SupportListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       // mainView.applyShodowToBottom()
        self.selectionStyle = .none
        titleLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
