//
//  CreateAccountCityViewController.swift
//  remuda
//
//  Created by mac on 08/04/21.
//

import UIKit
import GooglePlaces

class CreateAccountCityViewController: UIViewController{
    
    @IBOutlet weak var lblTilte: UILabel!
    @IBOutlet weak var lblUse: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    private var placesClient: GMSPlacesClient!
    var viewModel = RegisterViewModel()
    var profiledetail : ProfileDetailModel?
    var profileImage :UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesClient = GMSPlacesClient.shared()
        self.setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnNext.setUpCornerRadius(5)
    }
    private func setUpUI(){
        txtCity.delegate = self
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.createAccount.rawValue
        
        lblTilte.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        
        lblUse.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        txtCity.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblUse.textColor = .label_gray_color_2
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size:setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSkip.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSkip.setTitleColor(.button_gray_color, for: .normal)
    }
    
    @IBAction func onTapNext(_ sender: Any) {
        if self.txtCity.text == ""{
            showAlert(message: getLocalizedString(key: .enterYourCity))
        }else{
           // self.signUpAPICall()
            self.profilePicUploadAndRegister()
        }
    }
    
    @IBAction func onTapSkip(_ sender: Any) {
        //self.signUpAPICall()
        self.profilePicUploadAndRegister()
    }
}
//MARK:- API calling for Image upload and register details.
extension CreateAccountCityViewController {
    
    func profilePicUploadAndRegister(){
        if let image = self.profileImage as? UIImage{
            AWSS3Manager.shared.uploadImage(image: image) { (progress) in
                showActivityIndicator(uiView: self.view)
                print("Uploading progress: \(progress)")
            } completion: { (uploadedFileUrl, error) in
                if let finalPath = uploadedFileUrl as? String {
                    hideActivityIndicator(uiView: self.view)
                    let a = "Uploaded file url: " + finalPath
                    print(a)
                    storeRegisterData.image = finalPath
                    self.signUpAPICall()
                } else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                }
            }
        }
    }
    
    func signUpAPICall(){
        storeRegisterData.city = txtCity.text
        
        showActivityIndicator(uiView: self.view)
        var dict = [String:Any]()
        if storeRegisterData.email != "" || storeRegisterData.email != nil {
            dict["email"] = storeRegisterData.email
        }
        if storeRegisterData.password != "" || storeRegisterData.password != nil {
            dict["password"] = storeRegisterData.password
        }
        if storeRegisterData.age != 0 || storeRegisterData.age != nil {
            dict["age"] = storeRegisterData.age
        }
        if storeRegisterData.first_name != "" || storeRegisterData.first_name != nil {
            dict["first_name"] = storeRegisterData.first_name
        }
        if storeRegisterData.last_name != "" || storeRegisterData.last_name != nil {
            dict["last_name"] = storeRegisterData.last_name
        }
        if storeRegisterData.mobileNo != "" || storeRegisterData.mobileNo != nil {
            dict["mobile"] = storeRegisterData.mobileNo
        }
        if storeRegisterData.city != "" || storeRegisterData.city != nil {
            dict["city"] = storeRegisterData.city
        }
        if storeRegisterData.login_id != "" || storeRegisterData.login_id != nil {
            dict["login_id"] = storeRegisterData.login_id
        }
        if storeRegisterData.loginType != nil {
            dict["login_type"] = storeRegisterData.loginType
        }
        if storeRegisterData.image != "" || storeRegisterData.image != nil{
            dict["image"] = storeRegisterData.image
        }
        
        viewModel.callRegisterAPI(params: dict) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                let resData = dict
                print(resData)
                sceneDelegate?.setUpRootViewController()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension CreateAccountCityViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        return true
    }
}
extension CreateAccountCityViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        placesClient?.findAutocompletePredictions(fromQuery: place.name ?? "" , filter: filter, sessionToken: nil, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            for result in results ?? [GMSAutocompletePrediction](){
                if let result = result as? GMSAutocompletePrediction {
                    if place.placeID == result.placeID {
                        self.txtCity.text = (result.attributedFullText.string) as! String
                        break
                    }
                }
            }
        })
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
