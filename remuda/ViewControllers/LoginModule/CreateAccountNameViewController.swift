//
//  CreateAccountNameViewController.swift
//  remuda
//
//  Created by mac on 07/04/21.
//

import UIKit

class CreateAccountNameViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecondName: UITextField!
    var firstName = String()
    var lastName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.createAccount.rawValue
        
        self.txtFirstName.text = self.firstName
        self.txtSecondName.text = self.lastName
        lblTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtFirstName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtSecondName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnNext.setUpCornerRadius(5)
    }
    @IBAction func onTapNext(_ sender: UIButton) {
        if txtFirstName.text == "" {
            self.showAlert(message: getLocalizedString(key: .enterFirstName))
            return
        }
        else if txtSecondName.text == "" {
            self.showAlert(message: getLocalizedString(key: .enterSecondName))
            return
        }
        storeRegisterData.first_name = (txtFirstName.text ?? "")
        storeRegisterData.last_name =  (txtSecondName.text ?? "")
        self.pushViewController(controllerID: .CreateAccountProfilePhotoVC, storyBoardID: .Main)
        //self.pushViewController(controllerID: .CreateAccountPhoneVC, storyBoardID: .Main)
    }
    
    
    
}
