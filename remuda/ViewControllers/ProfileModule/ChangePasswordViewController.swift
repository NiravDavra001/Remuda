//
//  ChangePasswordViewController.swift
//  remuda
//
//  Created by Macmini on 20/07/21.
//

import UIKit
protocol ChangePasswordDelegate {
    func changePasswordToast()
}
class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet var oldPasswordView: UIView!
    @IBOutlet var newPasswordView: UIView!
    @IBOutlet var confirmNewPasswordView: UIView!
    @IBOutlet var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmNewPassword: UITextField!
    @IBOutlet weak var lblRecommand: UILabel!
    @IBOutlet weak var lblStatement1: UILabel!
    @IBOutlet weak var lblStatement2: UILabel!
    @IBOutlet weak var lblStatement3: UILabel!
    @IBOutlet weak var lblStatement4: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    var delegate: ChangePasswordDelegate?
    var changePasswordViewModel = ChangePasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSubmit.setUpCornerRadius(5)
    }
    private func setUpUI(){
        self.setBackButtonTitleHide()
        self.txtNewPassword.isUserInteractionEnabled = false
        self.txtConfirmNewPassword.isUserInteractionEnabled = false
        self.txtNewPassword.isSecureTextEntry = true
        self.txtOldPassword.isSecureTextEntry = true
        self.txtConfirmNewPassword.isSecureTextEntry = true
        self.btnSubmit.isUserInteractionEnabled = false
        self.btnSubmit.alpha = 0.5
        self.oldPasswordView.setBorder(1, .personalInformationBorder, 3)
        self.newPasswordView.setBorder(1, .personalInformationBorder, 3)
        self.confirmNewPasswordView.setBorder(1, .personalInformationBorder, 3)
        self.title = ViewControllerTitle.changePassword.rawValue
        self.txtOldPassword.delegate = self
        self.txtNewPassword.delegate = self
        self.txtConfirmNewPassword.delegate = self
        self.txtOldPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtNewPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtConfirmNewPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        self.lblRecommand.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.lblStatement1.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        self.lblStatement2.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        self.lblStatement3.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        self.lblStatement4.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
        
        self.lblRecommand.textColor = .label_statement_gray_color_3
        self.lblStatement1.textColor = .label_statement_gray_color_3
        self.lblStatement2.textColor = .label_statement_gray_color_3
        self.lblStatement3.textColor = .label_statement_gray_color_3
        self.lblStatement4.textColor = .label_statement_gray_color_3
        
        self.lblStatement1.text = "\u{2022}  Not used anywhere else"
        self.lblStatement2.text = "\u{2022}  Over 8 characters long"
        self.lblStatement3.text = "\u{2022}  Uses both upper and lower case characters"
        self.lblStatement4.text = "\u{2022}  Uses numbers and/or special symbols (!@$^*)"
        
        self.btnSubmit.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    @IBAction func onTapSubmit(_ sender: Any) {
        if txtOldPassword.text == "" || txtOldPassword.text?.isEmpty == true {
            self.showAlert(message: getLocalizedString(key: .enterOldPassword))
            return
        } else if txtOldPassword.text?.validatePassword() == false {
            self.showAlert(message: getLocalizedString(key: .validPassword))
            return
        } else if txtNewPassword.text == "" || txtNewPassword.text?.isEmpty == true {
            self.showAlert(message: getLocalizedString(key: .enterNewPassword))
            return
        } else if txtNewPassword.text?.validatePassword() == false {
            self.showAlert(message: getLocalizedString(key: .validPassword))
            return
        } else if txtOldPassword.text == txtNewPassword.text {
            self.showAlert(message: getLocalizedString(key: .oldPasswordNewPassword))
            return
        } else if txtConfirmNewPassword.text == "" || txtConfirmNewPassword.text?.isEmpty == true {
            self.showAlert(message: getLocalizedString(key: .enterConfirmPasswrod))
            return
        } else if txtConfirmNewPassword.text?.validatePassword() == false {
            self.showAlert(message: getLocalizedString(key: .validPassword))
            return
        } else if txtNewPassword.text != txtConfirmNewPassword.text {
            self.showAlert(message: getLocalizedString(key: .enterMatchPassword))
            return
        } else {
            self.changePasswordViewModel.dict.removeAll()
            self.changePasswordViewModel.dict["oldpass"] = txtOldPassword.text
            self.changePasswordViewModel.dict["newpass"] = txtNewPassword.text
            self.changePasswordAPICall()
        }
    }
}
//MARK: UITextfields delegate methods.
extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.txtOldPassword:
            if self.txtOldPassword.text?.validatePassword() == false{
                if self.txtOldPassword.text != "" {
                    self.oldPasswordView.setBorder(1, .postLike_red_color, 3)
                    self.txtNewPassword.isUserInteractionEnabled = false
                    self.txtConfirmNewPassword.isUserInteractionEnabled = false
                    self.btnSubmit.isUserInteractionEnabled = false
                }else{
                    self.oldPasswordView.setBorder(1, .personalInformationBorder, 3)
                }
            }else{
                self.txtNewPassword.isUserInteractionEnabled = true
                self.oldPasswordView.setBorder(1, .personalInformationBorder, 3)
            }
        case self.txtNewPassword:
            if self.txtNewPassword.text?.validatePassword() == false{
                if self.txtNewPassword.text != "" {
                    self.newPasswordView.setBorder(1, .postLike_red_color, 3)
                    self.txtConfirmNewPassword.isUserInteractionEnabled = false
                    self.btnSubmit.isUserInteractionEnabled = false
                }else{
                    self.newPasswordView.setBorder(1, .personalInformationBorder, 3)
                }
            }else{
                self.txtConfirmNewPassword.isUserInteractionEnabled = true
                self.newPasswordView.setBorder(1, .personalInformationBorder, 3)
            }
        case self.txtConfirmNewPassword:
            if self.txtConfirmNewPassword.text?.validatePassword() == false{
                if self.txtConfirmNewPassword.text != "" {
                    self.confirmNewPasswordView.setBorder(1, .postLike_red_color, 3)
                    self.btnSubmit.isUserInteractionEnabled = false
                }else{
                    self.confirmNewPasswordView.setBorder(1, .personalInformationBorder, 3)
                }
                
            }else{
                self.btnSubmit.isUserInteractionEnabled = true
                self.confirmNewPasswordView.setBorder(1, .personalInformationBorder, 3)
            }
        default:
            self.showAlert(message: getLocalizedString(key: .validPassword))
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.switchBasedNextTextField(textField)
        if self.btnSubmit.isUserInteractionEnabled == false {
            self.btnSubmit.alpha = 0.5
        }else{
            self.btnSubmit.alpha = 1
        }
        return true
    }
}
//MARK: API calling.
extension ChangePasswordViewController {
    private func changePasswordAPICall() {
        showActivityIndicator(uiView: self.view)
        
        self.changePasswordViewModel.changeProfilePasswordAPI { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.popViewController()
                self.delegate?.changePasswordToast()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

