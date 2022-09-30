//
//  CreatePadigreeMapTableViewCell.swift
//  remuda
//
//  Created by Macmini on 26/07/21.
//

import UIKit
protocol AddNewHorseDelegate {
    func addNewHorseAction(indexPath: IndexPath)
}
class CreatePadigreeMapTableViewCell: UITableViewCell {
    @IBOutlet var aboveColorView: UIView!
    @IBOutlet var detailView: UIView!
    @IBOutlet var btnNewHorse: UIButton!
    @IBOutlet var lblBornDate: UILabel!
    @IBOutlet var lblHorseName: UILabel!
    @IBOutlet var lblRegistrationId: UILabel!
    @IBOutlet var detailStackView: UIStackView!
    var indexPath = IndexPath()
    var delegate: AddNewHorseDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setUpUI()
    }
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.detailView.dropShadow()
    }
    
    private func setUpUI() {
        self.detailStackView.isHidden = true
        self.lblBornDate.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.lblBornDate.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.lblBornDate.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.lblBornDate.textColor = UIColor(red: 0.772, green: 0.772, blue: 0.772, alpha: 1)
    }
    @IBAction func btnNewHorseAction(_ sender: UIButton) {
        self.delegate?.addNewHorseAction(indexPath: self.indexPath)
    }
    
}
