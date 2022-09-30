//
//  PedigreeHorseDetailsTableViewCell.swift
//  remuda
//
//  Created by Macmini on 26/07/21.
//

import UIKit

class PedigreeHorseDetailsTableViewCell: UITableViewCell {
    @IBOutlet var genderView: UIView!
    @IBOutlet var btnSelect: UIButton!
    @IBOutlet var backView: UIView!
    @IBOutlet var leadigSpace: NSLayoutConstraint!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblHorseName: UILabel!
    @IBOutlet var lblid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backView.dropShadow()
    }
    
    @IBAction func btnUpDownAction(_ sender: Any) {
    }
}
