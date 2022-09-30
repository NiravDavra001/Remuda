//
//  ResetPasswordViewController.swift
//  remuda
//
//  Created by mac on 08/04/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatement: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    var viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.resetPassword.rawValue
        
        lblTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        
        lblStatement.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtEmail.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblStatement.textColor = .label_gray_color_2
        btnSubmit.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSubmit.setUpCornerRadius(5)
    }
    
    @IBAction func onTapSubmit(_ sender: Any) {
        showActivityIndicator(uiView: self.view)
        viewModel.callUserMailVerificationAPI(params: ["email" : txtEmail.text ?? ""]) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.pushViewController(controllerID: .ConfirmationMailVC, storyBoardID: .Main)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
}
