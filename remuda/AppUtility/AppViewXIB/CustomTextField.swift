//
//  CustomTextField.swift
//  remuda
//
//  Created by Macmini on 27/04/21.
//

import UIKit

final class CustomTextField: UIView{
    
    @IBOutlet var viewBorder: UIView!
    @IBOutlet var txtCustomField: SkyFloatingLabelTextField!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "CustomTextField", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    } 
    func setUpUI(){
        txtCustomField.delegate = self
        self.viewBorder.setBorder(1, .horseListing_border_gray, 3)
        self.txtCustomField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtCustomField.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtCustomField.titleColor = UIColor.personalInformationTFlabel
        self.txtCustomField.selectedTitleColor = .app_green_color
        self.txtCustomField.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtCustomField.tintColor = .app_green_color
    }
}
extension CustomTextField : UITextFieldDelegate {
}
