//
//  ProfileViewController.swift
//  remuda
//
//  Created by Priya Dhola on 10/04/21.
//

struct UpdateProfile {
    var email : String?
    var city : String?
    var last_name : String?
    var mobile: String?
    var first_name : String?
    var image : String?
    var horsePlanDate : String?
    var horsePlanId : Int?
    var tackPlanDate : String?
    var tackPlanId : Int?
    var equipmentPlanDate : String?
    var equipmentPlanId : Int?
}

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var lblNavigationTitle: UILabel!
    @IBOutlet var tblProfile: UITableView!
    var profileData = [ProfileModel]()
    var viewModel = ProfileDetailViewModel()
    var arrDetails : ProfileDetailModel?
    var isCalled = true
    var updateProfileViewModel = MyProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    func getUserProfileCallAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.getUserProfileAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.arrDetails  = self.viewModel.getUserProfileList
                UserDefaultManager.share.storeModelToUserDefault(userData: self.arrDetails, key: .storeProfile)
                self.tblProfile.reloadData()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func callImageUpdateAPI(params: UpdateProfile){
        showActivityIndicator(uiView: self.view)
        updateProfileViewModel.callMyProfileAPI(params: params) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.arrDetails  = self.updateProfileViewModel.getUserProfileList
                UserDefaultManager.share.storeModelToUserDefault(userData: self.arrDetails, key: .storeProfile)
                self.tblProfile.reloadData()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func setUpUI(){
        tblProfile.dataSource = self
        tblProfile.delegate = self
        tblProfile.register(UINib(nibName: TableCellIdentifiers.ProfileDetailTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.ProfileDetailTVCell.rawValue)
        tblProfile.register(UINib(nibName: TableCellIdentifiers.ProfileHeader.rawValue, bundle: nil), forHeaderFooterViewReuseIdentifier: TableCellIdentifiers.ProfileHeader.rawValue)
        tblProfile.register(UINib(nibName: TableCellIdentifiers.SignOutFooter.rawValue, bundle: nil), forHeaderFooterViewReuseIdentifier: TableCellIdentifiers.SignOutFooter.rawValue)
        tblProfile.separatorStyle = .none
        
        lblNavigationTitle.text = ViewControllerTitle.yourProfile.rawValue
        lblNavigationTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_20))
        profileData = [
            ProfileModel(title: .personalInformation),
            ProfileModel(title: .bookmarks),
            ProfileModel(title: .support)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getUserProfileCallAPI()
    }
    
    func createAlert(message : String , btnText1 : String ,btnText2 : String){
        let alert = UIAlertController(title: "Remuda", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnText1, style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: btnText2, style: .destructive, handler: { (_) in
            
            UserDefaultManager.share.clearAllUserDataAndModel()
            UserDefaultManager.share.removeUserDefualtsModels(key: .storePreviousSearch)
            let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Main.rawValue, bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.mainVC.rawValue)
            let navContller = UINavigationController(rootViewController: homeViewController)
            sceneDelegate?.window?.rootViewController = navContller
            sceneDelegate?.window?.makeKeyAndVisible()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.ProfileDetailTVCell.rawValue) as? ProfileDetailTableViewCell
        profileDetailTableViewCell?.selectionStyle = .none
        profileDetailTableViewCell?.lblProfileCellData.text = profileData[indexPath.row].title.rawValue
        return profileDetailTableViewCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64 * UIScreen.main.bounds.height / 812
    }
    
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableCellIdentifiers.ProfileHeader.rawValue) as? ProfileHeader
        profileHeader?.lblUserName.text = ("\(arrDetails?.data?.firstName ?? "") \(arrDetails?.data?.lastName ?? "")")
        let imgUrl = arrDetails?.data?.image
        profileHeader?.imgProfile.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        
        profileHeader?.lblUserLocation.text = arrDetails?.data?.city ?? ""
        profileHeader?.delegate = self
        return profileHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 121 * UIScreen.main.bounds.height / 812
    }
    
    //MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let signOutFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableCellIdentifiers.SignOutFooter.rawValue) as? SignOutFooter
        signOutFooter?.delegate = self
        return signOutFooter
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64 * UIScreen.main.bounds.height / 812
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch profileData[indexPath.row].title{
        case .personalInformation:
            let vc = loadViewController(Storyboard: .Profile, ViewController: .ProfileInformationVC) as! ProfileInformationViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case .bookmarks:
            self.pushViewController(controllerID: .BookmarksVC, storyBoardID: .Profile)
        case .support:
            let vc = loadViewController(Storyboard: .Profile, ViewController: .supportVC) as! SupportViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProfileViewController: SelectImageAlertDelegate{
    func showAlert() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(message: "Camera is not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func tappedStackView() {
        let vc = loadViewController(Storyboard: .Profile, ViewController: .ProfileInformationVC) as! ProfileInformationViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { 
        
        if let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
            AWSS3Manager.shared.uploadImage(image: image) { (progress) in
                picker.dismiss(animated: true, completion: nil)
                showActivityIndicator(uiView: self.view)
                print("Uploading progress: \(progress)")
            } completion: { (uploadedFileUrl, error) in
                if let finalPath = uploadedFileUrl as? String {
                    let a = "Uploaded file url: " + finalPath
                    print(a)
                    profileUpdate.image = finalPath
                    self.callImageUpdateAPI(params: profileUpdate)
                    hideActivityIndicator(uiView: self.view)
                } else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: TableviewReloadDelegate{
    func reloadTableview() {
        self.tblProfile.reloadData()
    }
    
    func signOut() {
        createAlert(message: "Are you sure?", btnText1: "Cancel", btnText2: "Logout")
    }
    
    func updateProfileHeaderData(firstName: String, lastName: String) {
        arrDetails?.data?.firstName = firstName
        arrDetails?.data?.lastName = lastName
    }
}
