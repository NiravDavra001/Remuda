//
//  SignInViewController.swift
//  remuda
//
//  Created by mac on 31/03/21.
//

import UIKit
import AuthenticationServices
import AuthenticationServices
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {
    
    @IBOutlet weak var appleView: AppButtonView!
    @IBOutlet weak var facebookView: AppButtonView!
    @IBOutlet weak var googleView: AppButtonView!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var sepraterView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var viewModel = LoginViewModel()
    var checkEmailViewModel = CheckEmailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.title = ""
    }
    
    func setUpUI(){
        self.setBackButtonTitleHide()
        self.title = ViewControllerTitle.signIn.rawValue
        self.txtPassword.isSecureTextEntry  = true
        txtEmail.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtPassword.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        appleView.image.image = UIImage(named: "AppleLogo")
        appleView.setButtonTitleColor(color: .black)
        appleView.setButton(name: "Sign In with Apple",imageName:"AppleLogo")
        appleView.backgroundColor = .buttonBackgroundColor
        appleView.setBorder(1.0, .button_border_color)
        
        googleView.image.image = UIImage(named: "GoogleLogo")
        googleView.setButtonTitleColor(color: .black)
        googleView.setButton(name: "Sign In with Google",imageName:"GoogleLogo")
        googleView.backgroundColor = .buttonBackgroundColor
        googleView.setBorder(1.0, .button_border_color)
        
        facebookView.image.image = UIImage(named: "FBLogo")
        facebookView.setButtonTitleColor(color: .black)
        facebookView.setButton(name: "Sign In with Facebook",imageName:"FBLogo")
        facebookView.backgroundColor = .buttonBackgroundColor
        facebookView.setBorder(1.0, .button_border_color)
        
        btnSignIn.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        btnForgotPassword.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnForgotPassword.setTitleColor(.appFontPlaceholderColor, for: .normal)
        
        lblOr.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblOr.textColor = .appFontPlaceholderColor
        sepraterView.backgroundColor = .appFontPlaceholderColor
        
        appleView.Button.isUserInteractionEnabled = true
        appleView.Button.addTarget(self, action: #selector(handleAppleIdRequest(_:)), for: .touchUpInside)
        
        appleView.setUpCornerRadius(3)
        appleView.Button.addTarget(self, action: #selector(handleAppleIdRequest(_:)), for: .touchUpInside)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate  = self
        
        googleView.Button.addTarget(self, action: #selector(ontapGoogleLogin), for: .touchUpInside)
        facebookView.Button.addTarget(self, action: #selector(onTapFBLogin), for: .touchUpInside)
    }
    
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
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
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
                    
                    self.checkEmailViewModel.callUserMailVerificationAPI(params: ["email" : id]) { (isFinished, message) in
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
                            self.viewModel.dict["login_id"] = id
                            self.viewModel.dict["login_type"] = 2
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
                    print("error : ",error?.localizedDescription ?? "")
                }
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        appleView.setUpCornerRadius(5)
        facebookView.setUpCornerRadius(5)
        googleView.setUpCornerRadius(5)
        btnSignIn.setUpCornerRadius(5)
    }
    
    @IBAction func onTapForgotPassword(_ sender: Any) {
        self.pushViewController(controllerID: .ResetPasswordVC, storyBoardID: .Main)
    }
    @IBAction func onTapSingIn(_ sender: Any) {
        //  go to home screen or otp screen from here
        
        if txtEmail.text == "" || txtEmail == nil {
            self.showAlert(message: getLocalizedString(key: .enterEmail))
            return
        }
        else if txtPassword.text == "" || txtPassword == nil {
            self.showAlert(message: getLocalizedString(key: .enterPassword))
            return
        }
        
        if txtEmail.text?.isValidEmail() == false {
            self.showAlert(message: getLocalizedString(key: .validEmail))
        }
        viewModel.dict.removeAll()
        viewModel.dict["email"] = txtEmail.text
        viewModel.dict["password"] = txtPassword.text
        viewModel.dict["login_type"] = 1
        callLoginAPI {
        }
    }
    
    func callLoginAPI(completion: @escaping () -> ()){
        showActivityIndicator(uiView: self.view)
        
        viewModel.callLoginAPI { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                checkLoginViewController(storyBoard: .Home, viewController: .TabBarController)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        appleView.setUpCornerRadius(3)
        facebookView.setUpCornerRadius(3)
        appleView.setUpCornerRadius(3)
    }
    @objc func ontapGoogleLogin(){
        //        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func handleAppleIdRequest(_ sender : UIButton) {
        DispatchQueue.main.async {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        }
    }
    
}

extension SignInViewController: ASAuthorizationControllerDelegate{
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
                    self.checkEmailViewModel.callUserMailVerificationAPI(params: ["email" : appleIDCredential.user]) { (isFinished, message) in
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
                            self.viewModel.dict["login_id"] = appleIDCredential.user
                            self.viewModel.dict["login_type"] = 4
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
//                    
//                    
//                    self.viewModel.dict["login_id"] = storeRegisterData.login_id
//                    self.viewModel.dict["login_type"] = storeRegisterData.loginType
//                    DispatchQueue.main.async {
//                        self.callLoginAPI {
//                        }
//                    }
                    break
                case .revoked:
                    // The Apple ID credential is revoked.
                    break
                case .notFound:
                    break
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

extension SignInViewController : GIDSignInDelegate{
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
        
        checkEmailViewModel.callUserMailVerificationAPI(params: ["email" : user.profile.email ?? ""]) { (isFinished, message) in
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
                self.viewModel.dict["login_id"] = user.userID
                self.viewModel.dict["login_type"] = 3
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
