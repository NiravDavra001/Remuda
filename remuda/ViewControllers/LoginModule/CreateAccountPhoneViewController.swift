//
//  CreateAccountPhoneViewController.swift
//  remuda
//
//  Created by mac on 08/04/21.
//

import UIKit

class CreateAccountPhoneViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
   
    
    var countryPicker = genralPickerView()
    var profileImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.createAccount.rawValue
        
        countryPicker.frame = CGRect(x: 0, y: self.view.bounds.height + self.view.bounds.height * 0.2, width: self.view.bounds.width, height: self.view.bounds.height * 0.25)
        self.view.addSubview(countryPicker)
        
        txtPhoneNumber.setBorder(1, .button_border_color)
        btnCountryCode.setBorder(1, .button_border_color)
        btnCountryCode.addTarget(self, action: #selector(onTapCountryCode), for: .touchUpInside)
        
        txtPhoneNumber.setLeftPaddingPoints(btnCountryCode.frame.width )
        
        lblTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        btnCountryCode.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtPhoneNumber.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSkip.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSkip.setTitleColor(.button_gray_color, for: .normal)
    }
    
    @objc func onTapCountryCode(){
        let vc = HeadMobileNoViewController(nibName: "HeadMobileNoViewController", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.setUpCornerRadius(5)
    }
    
    @IBAction func onTapNext(_ sender: Any) {
        storeRegisterData.mobileNo = txtPhoneNumber.text ?? ""
        if txtPhoneNumber.text == ""{
            showAlert(message: getLocalizedString(key: .enterYourPhoneNumber))
        }else if txtPhoneNumber.text?.isValidPhone() == false {
            self.showAlert(message: getLocalizedString(key: .validPhone))
        }else{
            let cityVc = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountCityVC) as! CreateAccountCityViewController
            cityVc.profileImage = profileImage
            self.navigationController?.pushViewController(cityVc, animated: true)
        }
    }
    @IBAction func onTapSkip(_ sender: Any) {
        let cityVc = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountCityVC) as! CreateAccountCityViewController
        cityVc.profileImage = profileImage
        self.navigationController?.pushViewController(cityVc, animated: true)
    }
}
extension CreateAccountPhoneViewController : HeadMobileNoViewControllerDelegate{
    func setCountryCode(code: String, completion: @escaping () -> ()) {
        btnCountryCode.setTitle(code, for: .normal)
        completion()
    }
}
