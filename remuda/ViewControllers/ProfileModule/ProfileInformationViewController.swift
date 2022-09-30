//
//  ProfileInformationViewController.swift
//  remuda
//
//  Created by Macmini on 12/04/21.
//
protocol TableviewReloadDelegate {
    func reloadTableview()
    func updateProfileHeaderData(firstName: String, lastName: String)
    func signOut()
}
import UIKit
import GooglePlaces
import IQKeyboardManagerSwift

class ProfileInformationViewController: UIViewController {
    
    var delegate: TableviewReloadDelegate?
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnChangePassword: UIButton!
    @IBOutlet var firstNameView: UIView!
    @IBOutlet var lastNameView: UIView!
    @IBOutlet var phoneNumberView: UIView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var txtFirstName: SkyFloatingLabelTextField!
    @IBOutlet var txtLastName: SkyFloatingLabelTextField!
    @IBOutlet var txtPhoneNumber: SkyFloatingLabelTextField!
    @IBOutlet var txtAddress: SkyFloatingLabelTextField!
    @IBOutlet var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet var txtPassword: SkyFloatingLabelTextField!
    var viewModel = MyProfileViewModel()
    private var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesClient = GMSPlacesClient.shared()
        self.setUpUI()
        self.setUpKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.btnSave.setUpCornerRadius(5)
    }
    private func setUpKeyboard() {
        self.view.manageKeyboard()
        self.txtFirstName.returnKeyType = .next
        self.txtLastName.returnKeyType = .next
        self.txtPhoneNumber.returnKeyType = .next
        self.txtAddress.returnKeyType = .next
        self.txtPassword.returnKeyType = .done
    }
    
    private func setUpUI(){
        
        let userDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: ProfileDetailModel.self, key: .storeProfile)
        self.txtFirstName.text = userDetails?.data?.firstName ?? ""
        self.txtLastName.text = userDetails?.data?.lastName ?? ""
        self.txtPhoneNumber.text = userDetails?.data?.mobile
        self.txtAddress.text = userDetails?.data?.city
        self.txtAddress.delegate = self
        self.txtEmail.text = userDetails?.data?.email
        self.txtEmail.isUserInteractionEnabled  = false
        self.txtEmail.textColor = .filterGrey
        self.txtPassword.text = "Tester@123"
        self.txtPassword.isSecureTextEntry  = true
        self.txtPassword.isUserInteractionEnabled =  false
        
        if userDetails?.data?.loginType != 1{
            self.passwordView.isHidden = true
        }else{
            self.passwordView.isHidden = false
        }
        
        self.title = ViewControllerTitle.personalInformation.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.btnSave.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.btnChangePassword.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        
        self.firstNameView.setBorder(1, .personalInformationBorder, 3)
        self.lastNameView.setBorder(1, .personalInformationBorder, 3)
        self.phoneNumberView.setBorder(1, .personalInformationBorder, 3)
        self.addressView.setBorder(1, .personalInformationBorder, 3)
        self.emailView.setBorder(1, .personalInformationBorder, 3)
        self.passwordView.setBorder(1, .personalInformationBorder, 3)
        
        self.txtFirstName.setSkyFloatingLabelTextField()
        self.txtLastName.setSkyFloatingLabelTextField()
        self.txtPhoneNumber.setSkyFloatingLabelTextField()
        self.txtAddress.setSkyFloatingLabelTextField()
        self.txtEmail.setSkyFloatingLabelTextField()
        self.txtPassword.setSkyFloatingLabelTextField()
        
    }
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = self.loadViewController(Storyboard: .Profile, ViewController: .ChangePasswordVC) as! ChangePasswordViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapSave(_ sender: Any) {
        profileUpdate.first_name = txtFirstName.text
        profileUpdate.last_name = txtLastName.text
        profileUpdate.mobile = txtPhoneNumber.text
        profileUpdate.city = txtAddress.text
        profileUpdate.email = txtEmail.text
        if txtPhoneNumber.text?.isValidPhone() == false {
            self.showAlert(message: getLocalizedString(key: .validPhone))
        }else{
            self.getProfileAPICall(params: profileUpdate)
            self.delegate?.reloadTableview()
        }
    }
    
}
//MARK:- API calling.
extension ProfileInformationViewController {
    func getProfileAPICall(params: UpdateProfile){
        showActivityIndicator(uiView: self.view)
        viewModel.callMyProfileAPI(params: params) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                DispatchQueue.main.async {
                    if self.txtFirstName.text == "" {
                        self.showAlert(message: getLocalizedString(key: .enterFirstName))
                        return
                    }
                    else if self.txtLastName.text == "" {
                        self.showAlert(message: getLocalizedString(key: .enterSecondName))
                        return
                    }
                    else if self.txtAddress.text == "" {
                        self.showAlert(message: getLocalizedString(key: .enterYourCity))
                        return
                    }
                    else{
                        if let viewcontroller = self.navigationController?.viewControllers.first{
                            if viewcontroller == self{
                                let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Home.rawValue, bundle: nil)
                                let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.TabBarController.rawValue)
                                let navContller = UINavigationController(rootViewController: homeViewController)
                                sceneDelegate?.window?.rootViewController = navContller
                                sceneDelegate?.window?.makeKeyAndVisible()
                            }else{
                                self.popViewController()
                            }
                        }
                    }
                }
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension ProfileInformationViewController: UITextFieldDelegate{
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

extension ProfileInformationViewController: GMSAutocompleteViewControllerDelegate {
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
                        self.txtAddress.text = (result.attributedFullText.string) as! String
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

extension ProfileInformationViewController: ChangePasswordDelegate {
    func changePasswordToast() {
        self.showToast(message: "Password updated Successfully...", font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))!)
    }
}
