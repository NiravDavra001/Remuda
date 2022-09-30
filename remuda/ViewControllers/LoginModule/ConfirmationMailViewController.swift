//
//  ConfirmationMailViewController.swift
//  remuda
//
//  Created by mac on 08/04/21.
//

import UIKit

class ConfirmationMailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatement: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    @IBOutlet weak var btnBackToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.resetPassword.rawValue
        
        lblTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        
        lblStatement.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblStatement.textColor = .label_gray_color_2
        
        btnTryAgain.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnBackToLogin.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnTryAgain.setUpCornerRadius(5)
        btnBackToLogin.setUpCornerRadius(5)
    }
    
    @IBAction func onTapTryAgain(_ sender: Any) {
        self.dismissViewController()
    }
    @IBAction func btnBackToLogin(_ sender: UIButton) {
        self.dismissViewController()
    }
}
