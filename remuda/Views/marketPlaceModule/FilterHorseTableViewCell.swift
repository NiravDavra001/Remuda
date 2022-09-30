//
//  FilterHorseTableViewCell.swift
//  remuda
//
//  Created by Macmini on 08/06/21.
//
protocol OpenGeneralPickerDelegate {
    func openPickerView(indexPath: IndexPath)
}
import UIKit

class FilterHorseTableViewCell: UITableViewCell {

    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblFilter: UILabel!
    @IBOutlet var btnRight: UIButton!
    var agePicker = genralPickerView()
    var delegate: OpenGeneralPickerDelegate?
    var indexPath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    func setUpUI(){
        lblCategory.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblFilter.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblFilter.textColor = .filterGrey
    }
    
    @IBAction func btnRight(_ sender: UIButton) {
    }
    
}

