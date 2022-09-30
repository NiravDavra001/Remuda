//
//  CreateAccountViewController.swift
//  remuda
//
//  Created by mac on 07/04/21.
//

import UIKit
import AuthenticationServices
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn

struct RegisterData {
    var email : String?
    var login_id : String?
    var password : String?
    var age : Int?
    var mobileNo : String?
    var first_name : String?
    var last_name : String?
    var city : String?
    var loginType : Int?
    var image : String?
}

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var appleView: AppButtonView!
    @IBOutlet weak var facebookView: AppButtonView!
    @IBOutlet weak var googleView: AppButtonView!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var sepraterView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet var txtViewPrivacyCondition: UITextView!
    @IBOutlet var txtViewHeight: NSLayoutConstraint!
    var viewModel = CheckEmailViewModel()
    var checkLoginViewModel = LoginViewModel()
    var agePicker = genralPickerView()
    var arrAge = [Int]()
    var loginID = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setUpUI()
        self.setUpPrivacyTermsLabel()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.setUpCornerRadius(5)
        self.txtViewHeight.constant = self.txtViewPrivacyCondition.contentSize.height
    }
    private func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.createAccount.rawValue
        self.txtPassword.isSecureTextEntry  = true
        txtEmail.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtAge.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        txtAge.inputView = agePicker.pickerView
        
        agePicker.delegate = self
        let height = (18...101).map { $0 * 1 }
        agePicker.dataSource.append(contentsOf: height.map { String($0) })
        
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        appleView.image.image = UIImage(named: "AppleLogo")
        facebookView.image.image = UIImage(named: "FBLogo")
        googleView.image.image = UIImage(named: "GoogleLogo")
        
        appleView.setButtonTitleColor(color: .black)
        facebookView.setButtonTitleColor(color: .black)
        googleView.setButtonTitleColor(color: .black)
        
        appleView.setButton(name: "Sign Up with Apple",imageName:"AppleLogo")
        facebookView.setButton(name: "Sign Up with Facebook",imageName:"FBLogo")
        googleView.setButton(name: "Sign Up with Google",imageName:"GoogleLogo")
        
        appleView.backgroundColor = .buttonBackgroundColor
        facebookView.backgroundColor = .buttonBackgroundColor
        googleView.backgroundColor = .buttonBackgroundColor
        
        appleView.setBorder(1.0, .button_border_color)
        facebookView.setBorder(1.0, .button_border_color)
        googleView.setBorder(1.0, .button_border_color)
        
        lblOr.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblOr.textColor = .appFontPlaceholderColor
        sepraterView.backgroundColor = .appFontPlaceholderColor
        
        appleView.setUpCornerRadius(3)
        facebookView.setUpCornerRadius(3)
        appleView.setUpCornerRadius(3)
        appleView.Button.addTarget(self, action: #selector(handleAppleIdRequest(_:)), for: .touchUpInside)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate  = self
        
        googleView.Button.addTarget(self, action: #selector(ontapGoogleLogin), for: .touchUpInside)
        facebookView.Button.addTarget(self, action: #selector(onTapFBLogin), for: .touchUpInside)
        
    }
    private func setUpPrivacyTermsLabel() {
        let string = "By continuing, you agree to the Terms of Service and acknowledge our Privacy Policy."
        let attributedString = NSMutableAttributedString(string: string)
        let rangeofstr1 = string.range(of: "Terms of Service")!
        let rangeofstr2 = string.range(of: "Privacy Policy")!
        let convertedRange1 = NSRange(rangeofstr1, in: string)
        let convertedRange2 = NSRange(rangeofstr2, in: string)
        
        
        attributedString.setAttributes([.link:"http://3.141.250.237/termsofuse.html",.font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!], range: convertedRange1)
        self.txtViewPrivacyCondition.linkTextAttributes = [.foregroundColor: UIColor.app_green_color]
        attributedString.setAttributes([.link:"http://3.141.250.237/privacypolicy.html",.font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!], range: convertedRange2)
        self.txtViewPrivacyCondition.linkTextAttributes = [.foregroundColor: UIColor.app_green_color]
        self.txtViewPrivacyCondition.isEditable = false
        self.txtViewPrivacyCondition.isUserInteractionEnabled = true
        self.txtViewPrivacyCondition.attributedText = attributedString
        self.txtViewPrivacyCondition.textAlignment = .center
        self.txtViewPrivacyCondition.delegate = self
    }
    @IBAction func onTapNext(_ sender: Any) {
        
        if self.txtEmail.text == "" {
            self.showAlert(message: getLocalizedString(key: .enterEmail))
            return
        }
        else if txtPassword.text == "" {
            self.showAlert(message: getLocalizedString(key: .enterPassword))
            return
        }
        else if txtAge.text == "" {
            self.showAlert(message: getLocalizedString(key: .enterAge))
            return
        }
        else if txtEmail.text?.isValidEmail() == false {
            self.showAlert(message: getLocalizedString(key: .validEmail))
            return
        }
        else if txtPassword.text?.validatePassword() == false {
            self.showAlert(message: getLocalizedString(key: .validPassword))
            return
        }
        
        storeRegisterData.email = self.txtEmail.text
        storeRegisterData.login_id = self.txtEmail.text
        storeRegisterData.age = Int(self.txtAge.text ?? "")
        storeRegisterData.password = self.txtPassword.text
        storeRegisterData.loginType = 1
        
        showActivityIndicator(uiView: self.view)
        viewModel.callUserMailVerificationAPI(params: ["email" : storeRegisterData.email ?? ""]) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.pushViewController(controllerID: .CreateAccountNameVC, storyBoardID: .Main)
            }
            else{
                self.showAlert(message: message)
            }
        }
        
    }
}
//MARK:- call login API
extension CreateAccountViewController{
    func callLoginAPI(completion: @escaping () -> ()){
        showActivityIndicator(uiView: self.view)
        
        checkLoginViewModel.callLoginAPI { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.checkLoginViewModel.dict.removeAll()
                completion()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
extension CreateAccountViewController:genralPickerViewDelegate{
    func setIndexOfPicker(str: String, picker: UIPickerView, txtField: UITextField?, index: Int) {
        self.txtAge.text = str
    }
}
//MARK:- Facebook. Google and Apple Login
extension CreateAccountViewController {
    @objc func onTapFBLogin(){
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if(error != nil){
                loginManager.logOut()
            }else if result!.isCancelled {
                loginManager.logOut()
            }else{
                //Handle login success
                
                self.getFBUserData()
            }
        }
    }
    func getFBUserData(){
        if AccessToken.current != nil{
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! [String : AnyObject]
                    guard let id = fbDetails["id"] as? String ,id != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    guard let name = fbDetails["first_name"] as? String ,name != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    guard let email = fbDetails["email"] as? String ,email != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    
                    self.viewModel.callUserMailVerificationAPI(params: ["email" : email]) { (isFinished, message) in
                        hideActivityIndicator(uiView: self.view)
                        if isFinished {
                            storeRegisterData.login_id = id
                            storeRegisterData.loginType = 2
                            storeRegisterData.email = email
                            let vc = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountNameVC) as! CreateAccountNameViewController
                            vc.firstName = fbDetails["first_name"] as? String ?? ""
                            vc.lastName = fbDetails["last_name"] as? String ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            self.checkLoginViewModel.dict["login_id"] = id
                            self.checkLoginViewModel.dict["login_type"] = 2
                            if isValidProfile(){
                                self.callLoginAPI {
                                    checkLoginViewController(storyBoard: .Home, viewController: .TabBarController)
                                }
                            }else{
                                self.callLoginAPI {
                                    checkLoginViewController(storyBoard: .Profile, viewController: .ProfileInformationVC)
                                }
                            }
                        }
                    }
                    print(fbDetails)
                }
                else{
                    print("error : ",error ?? "error")
                }
            })
        }
    }
    @objc func ontapGoogleLogin(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    @objc func handleAppleIdRequest(_ sender : UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
}

//MARK:- GIDSignInDelegate
extension CreateAccountViewController : GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        viewModel.callUserMailVerificationAPI(params: ["email" : user.profile.email ?? ""]) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                storeRegisterData.login_id = user.userID
                storeRegisterData.loginType = 3
                storeRegisterData.email = user.profile.email
                let vc = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountNameVC) as! CreateAccountNameViewController
                vc.firstName = user.profile.givenName ?? ""
                vc.lastName = user.profile.familyName ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.checkLoginViewModel.dict["login_id"] = user.userID
                self.checkLoginViewModel.dict["login_type"] = 3
                if isValidProfile(){
                    self.callLoginAPI {
                        checkLoginViewController(storyBoard: .Home, viewController: .TabBarController)
                    }
                }else{
                    self.callLoginAPI {
                        checkLoginViewController(storyBoard: .Profile, viewController: .ProfileInformationVC)
                    }
                }
            }
        }
    }
}

//MARK:- UITextView delegate method.
extension CreateAccountViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let vc = self.loadViewController(Storyboard: .Main, ViewController: .WebViewVC) as! WebViewViewController
        vc.url = URL
        self.present(vc, animated: true, completion: nil)
        return false
    }
}

extension CreateAccountViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
                switch credentialState {
                case .authorized:
                    
                    // The Apple ID credential is valid.
                    self.viewModel.callUserMailVerificationAPI(params: ["email" : appleIDCredential.email ?? ""]) { (isFinished, message) in
                        hideActivityIndicator(uiView: self.view)
                        if isFinished {
                            storeRegisterData.login_id = appleIDCredential.user
                            storeRegisterData.loginType = 4
                            storeRegisterData.email = appleIDCredential.email
                            let vc = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountNameVC) as! CreateAccountNameViewController
                            vc.firstName = appleIDCredential.fullName?.givenName ?? ""
                            vc.lastName = appleIDCredential.fullName?.familyName ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            self.checkLoginViewModel.dict["login_id"] = appleIDCredential.user
                            self.checkLoginViewModel.dict["login_type"] = 4
                            if isValidProfile(){
                                self.callLoginAPI {
                                    checkLoginViewController(storyBoard: .Home, viewController: .TabBarController)
                                }
                            }else{
                                self.callLoginAPI {
                                    checkLoginViewController(storyBoard: .Profile, viewController: .ProfileInformationVC)
                                }
                            }
                        }
                    }
                    
//                    storeRegisterData.login_id = appleIDCredential.user
//                    storeRegisterData.loginType = 4
//                    if appleIDCredential.email != nil {
//                        storeRegisterData.email = appleIDCredential.email
//                    }
//                    self.pushViewController(controllerID: .CreateAccountNameVC, storyBoardID: .Main)
                    //                    callSocialMediaLogin
                    break
                case .revoked:
                    // The Apple ID credential is revoked.
                    break
                case .notFound: break
                // No credential was found, so show the sign-in UI.
                default:
                    break
                }
            }
        }
        
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        
    }
    
}
