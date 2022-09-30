//
//  ContactInfoViewController.swift
//  remuda
//
//  Created by Macmini on 03/05/21.
//

import UIKit

class ContactInfoViewController: UIViewController {
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var viewLocation: UIView!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var viewEmail: UIView!
    @IBOutlet var txtLocation: SkyFloatingLabelTextField!
    @IBOutlet var txtPhone: SkyFloatingLabelTextField!
    @IBOutlet var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet var lblLocationInfo: UILabel!
    @IBOutlet var btnLocation: UIButton!
    @IBOutlet var btnPhone: UIButton!
    @IBOutlet var btnEmail: UIButton!
    @IBOutlet var stackView: UIStackView!
    var mode : MarketPlaceMode?
    let horseUploadViewModel = NewHorseListViewModel()
    var equipmentUploadViewModel = NewEquipmentListViewModel()
    var tackUploadViewModel = NewTackListViewModel()
    
    var dispatchGrp = DispatchGroup()
    var imgArray = [ImageModel?]()
    var mediaData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewDidLayoutSubviews() {
        btnNext.setUpCornerRadius(5)
        viewLocation.setBorder(1, .contactInfo_borderGray, 3)
        viewPhone.setBorder(1, .contactInfo_borderGray, 3)
        viewEmail.setBorder(1, .contactInfo_borderGray, 3)
    }
    
    private func setUpUI(){
        self.setUpData()
        
        txtLocation.isUserInteractionEnabled = false
        txtPhone.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        
        btnNext.backgroundColor = .app_green_color
        btnNext.titleLabel?.tintColor = .white
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        self.txtLocation.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtLocation.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtLocation.titleColor = UIColor.personalInformationTFlabel
        self.txtLocation.selectedTitleColor = .app_green_color
        self.txtLocation.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtLocation.tintColor = .app_green_color
        
        self.txtPhone.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtPhone.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtPhone.titleColor = UIColor.personalInformationTFlabel
        self.txtPhone.selectedTitleColor = .app_green_color
        self.txtPhone.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtPhone.tintColor = .app_green_color
        
        self.txtEmail.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtEmail.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtEmail.titleColor = UIColor.personalInformationTFlabel
        self.txtEmail.selectedTitleColor = .app_green_color
        self.txtEmail.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtEmail.tintColor = .app_green_color
        
        btnLocation.setTitleColor(.app_green_color, for: .normal)
        btnPhone.setTitleColor(.app_green_color, for: .normal)
        btnEmail.setTitleColor(.app_green_color, for: .normal)
        btnLocation.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnPhone.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnEmail.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblLocationInfo.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblLocationInfo.textColor = .app_lblUserLocation
        
        if UIScreen.main.bounds.height < 650{
            stackView.spacing = 20
        }else{
            stackView.spacing = 40
        }
    }
    private func setUpData(){
        self.setNavigationBarSubVCTitle(navTitle: .YourContactInfo)
        
        let userDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: ProfileDetailModel.self, key: .storeProfile)
        txtLocation.text = userDetails?.data?.city
        txtPhone.text = userDetails?.data?.mobile
        txtEmail.text = userDetails?.data?.email
    }
    
    func uploadMedia(endCompletion: @escaping () -> ()) {
        var count = 0
        _ = imgArray.compactMap { (element)  in
            self.btnNext.isUserInteractionEnabled = false
            self.btnNext.alpha = 0.5
            self.dispatchGrp.enter()
            showActivityIndicator(uiView: self.view)
            print("image = \(element?.image ?? UIImage())")
            if element?.videoUrl != nil{
                if let url = element?.videoUrl{
                    print("movieName = \(url)")
                    AWSS3Manager.shared.uploadVideo(videoUrl: url) { (progress) in
                        self.btnNext.isUserInteractionEnabled = false
                        print("Uploading progress: \(progress)")
                    } completion: { (uploadedFileUrl, error) in
                        if let finalPath = uploadedFileUrl as? String {
                            let a = "Uploaded file url: " + finalPath
                            print(a)
                            self.mediaData.append(finalPath)
                            self.dispatchGrp.leave()
                            let image = createThumbnailOfVideoFromRemoteUrl(url: finalPath){
                                self.showAlert(message: "An unexpected error occurred while uploading your image, please try again later")
                            }
                            //MARK:- video thumbnail.
                            AWSS3Manager.shared.uploadImage(image: image ?? UIImage()) { (progress) in
                                print("Uploading progress: \(progress)")
                            } completion: { (uploadedFileUrl, error) in
                                if let finalPath = uploadedFileUrl as? String {
                                    let a = "Uploaded file url: " + finalPath
                                    print(a)
                                    count += 1
                                    if count == self.imgArray.count {
                                        self.dispatchGrp.notify(queue: .main) {
                                            switch self.mode {
                                            case .horse:
                                                addHorseDetails.media = self.mediaData.joined(separator: ",")
                                                addHorseDetails.thumbnail = finalPath
                                            case .equipmment:
                                                addEquipmentDetails.media = self.mediaData.joined(separator: ",")
                                                addEquipmentDetails.thumbnail = finalPath
                                            case .tack:
                                                addTackDetails.media = self.mediaData.joined(separator: ",")
                                                addTackDetails.thumbnail = finalPath
                                            default:
                                                print("Something went wrong...")
                                            }
                                            hideActivityIndicator(uiView: self.view)
                                            self.btnNext.isUserInteractionEnabled = true
                                            self.btnNext.alpha = 1
                                            endCompletion()
                                        }
                                    }
                                } else {
                                    print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                                }
                            }
                        } else {
                            print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                        }
                    }
                }
            }else{
                AWSS3Manager.shared.uploadImage(image: element?.image ?? UIImage()) { (progress) in
                    print("Uploading progress: \(progress)")
                } completion: { (uploadedFileUrl, error) in
                    if let finalPath = uploadedFileUrl as? String {
                        let a = "Uploaded file url: " + finalPath
                        print(a)
                        self.mediaData.append(finalPath)
                        self.dispatchGrp.leave()
                        count += 1
                        if count == self.imgArray.count {
                            self.dispatchGrp.notify(queue: .main) {
                                hideActivityIndicator(uiView: self.view)
                                switch self.mode {
                                case .horse:
                                    addHorseDetails.media = self.mediaData.joined(separator: ",")
                                case .equipmment:
                                    addEquipmentDetails.media = self.mediaData.joined(separator: ",")
                                case .tack:
                                    addTackDetails.media = self.mediaData.joined(separator: ",")
                                default:
                                    print("Something went wrong...")
                                }
                                hideActivityIndicator(uiView: self.view)
                                self.btnNext.isUserInteractionEnabled = true
                                self.btnNext.alpha = 1
                                endCompletion()
                            }
                        }
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                    }
                }
            }
        }
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifiers.ContactInfoPopUPVC.rawValue) as! ContactInfoPopUPViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.tag = 1
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnPhone(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifiers.ContactInfoPopUPVC.rawValue) as! ContactInfoPopUPViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.tag = 2
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnEmail(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifiers.ContactInfoPopUPVC.rawValue) as! ContactInfoPopUPViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.tag = 3
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: UIButton) {
        if txtLocation.text == "" || txtLocation == nil {
            self.showAlert(message: getLocalizedString(key: .enterYourCity))
            return
        }
        else if txtPhone.text == "" || txtPhone == nil {
            self.showAlert(message: getLocalizedString(key: .enterPhone))
            return
        }
        else if txtEmail.text == "" || txtEmail == nil {
            self.showAlert(message: getLocalizedString(key: .enterEmail))
            return
        }
        else if txtPhone.text?.isValidPhone() == false {
            self.showAlert(message: getLocalizedString(key: .validPhone))
        }
        else if txtEmail.text?.isValidEmail() == false {
            self.showAlert(message: getLocalizedString(key: .validEmail))
        }else{
            switch mode {
            case .horse:
                
                horseUploadViewModel.dict["title"] = addHorseDetails.title
                horseUploadViewModel.dict["price"] = addHorseDetails.price
                horseUploadViewModel.dict["description"] = addHorseDetails.description
                horseUploadViewModel.dict["horse_breed"] = addHorseDetails.horse_breed
                horseUploadViewModel.dict["gender"] = addHorseDetails.gender
                horseUploadViewModel.dict["age"] = addHorseDetails.age
                horseUploadViewModel.dict["color"] = addHorseDetails.color
                horseUploadViewModel.dict["discipline"] = addHorseDetails.discipline
                horseUploadViewModel.dict["lifetimeearning"] = addHorseDetails.lifetimeearning
                horseUploadViewModel.dict["ability_level"] = addHorseDetails.ability_level
                horseUploadViewModel.dict["breeding_stock"] = addHorseDetails.breeding_stock
                horseUploadViewModel.dict["radiographs"] = addHorseDetails.radiographs
                horseUploadViewModel.dict["height"] = addHorseDetails.height
                horseUploadViewModel.dict["papers"] = addHorseDetails.papers
                horseUploadViewModel.dict["location"] = txtLocation.text
                horseUploadViewModel.dict["mobile"] = txtPhone.text
                horseUploadViewModel.dict["email"] = txtEmail.text
                horseUploadViewModel.dict["premium"] = addHorseDetails.premium
                
                if horseChildId == 0 || horseChildId == nil{
                    horseUploadViewModel.dict["siredamn"] = 2
                    horseUploadViewModel.dict["childids"] = 0
                    horseUploadViewModel.dict["is_child"] = 1
                    
                    uploadMedia {
                        self.horseUploadViewModel.dict["media"] = addHorseDetails.media
                        self.horseUploadViewModel.dict["thumbnail"] = addHorseDetails.thumbnail
                        self.addHorseUploadCallAPI()
                    }
                }else{
                    horseUploadViewModel.dict["horseid"] = mainHorseChildId
                    uploadMedia {
                        self.horseUploadViewModel.dict["media"] = addHorseDetails.media
                        self.horseUploadViewModel.dict["thumbnail"] = addHorseDetails.thumbnail
                        self.addHorseUploadCallAPI()
                    }
                }
            case .equipmment:
                addEquipmentDetails.location = txtLocation.text
                addEquipmentDetails.mobile = txtPhone.text
                addEquipmentDetails.email = txtEmail.text
                uploadMedia {
                    self.equipmentUploadCallAPI(dict: addEquipmentDetails)
                }
                
            case .tack:
                addTackDetails.location = txtLocation.text
                addTackDetails.mobile = txtPhone.text
                addTackDetails.email = txtEmail.text
                uploadMedia {
                    self.tackUploadcallAPI(params: addTackDetails)
                }
            default:
                break
            }
        }
    }
}
//MARK:- API call.
extension ContactInfoViewController {
    private func horseUploadCallAPI(){
        showActivityIndicator(uiView: self.view)
        horseUploadViewModel.updateHorseListAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.horseUploadViewModel.dict.removeAll()
                self.pushViewController(controllerID: .TabBarController, storyBoardID: .Home)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func addHorseUploadCallAPI(){
        showActivityIndicator(uiView: self.view)
        horseUploadViewModel.addHorseListAPI { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.horseUploadViewModel.dict.removeAll()
                self.pushViewController(controllerID: .TabBarController, storyBoardID: .Home)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    private func equipmentUploadCallAPI(dict : AddEquipmentDetails){
        showActivityIndicator(uiView: self.view)
        equipmentUploadViewModel.addEquipmentListAPI(params: dict) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.showToast(message: "You’ve successfully posted your listing", font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))!)
                self.pushViewController(controllerID: .TabBarController, storyBoardID: .Home)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    private func tackUploadcallAPI(params : AddTackDetails){
        showActivityIndicator(uiView: self.view)
        tackUploadViewModel.addTackListAPI(params: params) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.showToast(message: "You’ve successfully posted your listing", font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))!)
                self.pushViewController(controllerID: .TabBarController, storyBoardID: .Home)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension ContactInfoViewController: ContactInfoDelegate{
    func contactInfo(info: String,tag: Int) {
        switch tag {
        case 1:
            txtLocation.text = info
        case 2:
            txtPhone.text = info
        case 3:
            txtEmail.text = info
        default:
            break
        }
    }
}


