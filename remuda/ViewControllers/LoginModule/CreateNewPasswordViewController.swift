//
//  CreateNewPasswordViewController.swift
//  remuda
//
//  Created by mac on 08/04/21.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmNewPassword: UITextField!
    @IBOutlet weak var lblRecommand: UILabel!
    @IBOutlet weak var lblStatement1: UILabel!
    @IBOutlet weak var lblStatement2: UILabel!
    @IBOutlet weak var lblStatement3: UILabel!
    @IBOutlet weak var lblStatement4: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSubmit.setUpCornerRadius(5)
    }
    func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.createPassword.rawValue
        self.txtNewPassword.delegate = self
        self.txtConfirmNewPassword.delegate = self
        txtNewPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtConfirmNewPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        lblRecommand.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblStatement1.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        lblStatement2.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        lblStatement3.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        lblStatement4.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        
        lblRecommand.textColor = .label_statement_gray_color_3
        lblStatement1.textColor = .label_statement_gray_color_3
        lblStatement2.textColor = .label_statement_gray_color_3
        lblStatement3.textColor = .label_statement_gray_color_3
        lblStatement4.textColor = .label_statement_gray_color_3
        
        lblStatement1.text = "\u{2022}  Not used anywhere else"
        lblStatement2.text = "\u{2022}  Over 8 characters long"
        lblStatement3.text = "\u{2022}  Uses both upper and lower case characters"
        lblStatement4.text = "\u{2022}  Uses numbers and/or special symbols (!@$^*)"
        
        btnSubmit.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    
    
    @IBAction func onTapSubmit(_ sender: Any) {
    }
}

extension CreateNewPasswordViewController: UITextFieldDelegate {
    
    private func switchBasedNextTextField(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
