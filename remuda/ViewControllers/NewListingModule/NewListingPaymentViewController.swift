//
//  NewListingPaymentViewController.swift
//  remuda
//
//  Created by Macmini on 26/04/21.
//

enum IAPProduct {
    case horseBasicPost
    case horsePremiumPost
    case equipmentBasicPost
    case equipmentPremiumPost
    case tackBasicPost
    case tackPremiumPost
}

import UIKit

class NewListingPaymentViewController: UIViewController {
    
    @IBOutlet var lblGradient: UILabel!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var viewBasicPost: UIView!
    @IBOutlet var viewPremiumPost: UIView!
    @IBOutlet var viewBestValue: UIView!
    @IBOutlet var lblBasicPost: UILabel!
    @IBOutlet var lblFree: UILabel!
    @IBOutlet var lblBasicNoOfPhotos: UILabel!
    @IBOutlet var lblBasicVideoTime: UILabel!
    @IBOutlet var lblBasicListDays: UILabel!
    @IBOutlet var lblPremiumPost: UILabel!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblPremiumNoOfPhotos: UILabel!
    @IBOutlet var lblPremiumVideoTime: UILabel!
    @IBOutlet var lblPremiumListDays: UILabel!
    @IBOutlet var lblPremiumBoost: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var constraintTopAnchorPremiumView: NSLayoutConstraint!
    var listing: NewListingCategory?
    var listingCategory = [ListingCategoryModel]()
    var passPlanIDViewModel = MyProfileViewModel()
    var userProfileArrDetails : ProfileDetailModel?
    var planId: Int?
    
    var isViewBasicPostTapped = false
    var isviewPremiumPostTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpGradientLayer()
        setUpUI()
        setupUIViewTap()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewBasicPost.setBorder(1, .newListingPostBorder, 10)
        viewPremiumPost.setBorder(1, .newListingPostBorder, 10)
        viewBestValue.setUpCornerRadius(3)
        btnNext.setUpCornerRadius(5)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.constraintTopAnchorPremiumView.constant = -(self.viewBestValue.frame.height / 2)
        }
    }
    
    func setUpData(){
        switch listing {
        case .horse:
            lblFree.text = "$24.99"
            lblAmount.text = "$34.99"
        case .tack:
            lblFree.text = "$9.99"
            lblAmount.text = "$14.99"
        case .equipment:
            lblFree.text = "$24.99"
            lblAmount.text = "$34.99"
        default:
            break
        }
    }
    func setUpGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.91, green: 0.752, blue: 0.192, alpha: 1).cgColor,
            UIColor(red: 0.901, green: 0.412, blue: 0.202, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.50, y: 1)
        gradientLayer.frame = self.viewBestValue.bounds
        self.viewBestValue.layer.insertSublayer(gradientLayer, at:0)
    }
    func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .blank)
        lblGradient.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_11))
        lblQuestion.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
        lblBasicPost.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
        lblFree.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
        lblPremiumPost.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblAmount.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
        lblBasicNoOfPhotos.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblBasicVideoTime.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblBasicListDays.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPremiumNoOfPhotos.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPremiumVideoTime.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPremiumListDays.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPremiumBoost.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnNext.backgroundColor = .app_green_color
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    func setupUIViewTap() {
        let viewBasicPostTap = UITapGestureRecognizer(target:self, action: #selector(viewBasicPostTapped))
        viewBasicPost.addGestureRecognizer(viewBasicPostTap)
        let viewPremiumPostTap = UITapGestureRecognizer(target:self, action: #selector(viewPremiumPostTapped))
        viewPremiumPost.addGestureRecognizer(viewPremiumPostTap)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        IAPManager.shared.delegate = self
        if !isViewBasicPostTapped || !isviewPremiumPostTapped{
            switch listing {
            case .horse:
                switch self.planId {
                case 1:
                    print("Premium")
                    IAPManager.shared.purchase(productIdentifier: .remuda_horse_premium)
                case 2:
                    print("Basic")
                    IAPManager.shared.purchase(productIdentifier: .remuda_horse_basic)
                default:
                    break
                }
            case .tack:
                switch self.planId {
                case 1:
                    IAPManager.shared.purchase(productIdentifier: .remuda_tack_premium)
                case 2:
                    IAPManager.shared.purchase(productIdentifier: .remuda_tack_basic)
                default:
                    break
                }
            case .equipment:
                switch self.planId {
                case 1:
                    IAPManager.shared.purchase(productIdentifier: .remuda_equipment_premium)
                case 2:
                    IAPManager.shared.purchase(productIdentifier: .remuda_equipment_basic)
                default:
                    break
                }
            default:
                print("no data")
            }
        }else{
            self.showAlert(message: "Please select option")
        }
    }
}
//MARK:- UIView Tap @objc Funcnction
extension NewListingPaymentViewController{
    @objc func viewBasicPostTapped(sender: UITapGestureRecognizer){
        switch isViewBasicPostTapped {
        case false:
            isViewBasicPostTapped = true
            isviewPremiumPostTapped = false
            self.planId = 2
            self.viewBasicPost.setBorder(1, UIColor.black, 10)
            self.lblBasicPost.textColor = .app_green_color
            self.lblFree.textColor = .app_green_color
            self.viewPremiumPost.setBorder(1, .newListingPostBorder, 10)
            self.lblPremiumPost.textColor = .black
            self.lblAmount.textColor = .black
        case true:
            isViewBasicPostTapped = false
            self.planId = 1
            self.viewBasicPost.setBorder(1, .newListingPostBorder, 10)
            self.lblBasicPost.textColor = .black
            self.lblFree.textColor = .black
        }
    }
    
    @objc func viewPremiumPostTapped(sender: UITapGestureRecognizer){
        switch isviewPremiumPostTapped {
        case false:
            isviewPremiumPostTapped = true
            isViewBasicPostTapped = false
            self.planId = 1
            self.viewBasicPost.setBorder(1, .newListingPostBorder, 10)
            self.lblBasicPost.textColor = .black
            self.lblFree.textColor = .black
            self.viewPremiumPost.setBorder(1, UIColor.black, 10)
            self.lblPremiumPost.textColor = .app_green_color
            self.lblAmount.textColor = .app_green_color
        case true:
            isviewPremiumPostTapped = false
            self.planId = 2
            self.viewPremiumPost.setBorder(1, .newListingPostBorder, 10)
            self.lblPremiumPost.textColor = .black
            self.lblAmount.textColor = .black
        }
    }
}


extension NewListingPaymentViewController{
    func PaasPlanIDCallAPI(params: UpdateProfile){
        showActivityIndicator(uiView: self.view)
        passPlanIDViewModel.callMyProfileAPI(params: params) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.userProfileArrDetails  = self.passPlanIDViewModel.getUserProfileList
                UserDefaultManager.share.storeModelToUserDefault(userData: self.userProfileArrDetails, key: .storeProfile)
                switch self.listing {
                
                case .horse:
                    let horseVC = self.loadViewController(Storyboard: .NewListing, ViewController: .HorseListingVC) as! HorseListingViewController
                    horseVC.getPlanId = self.planId
                    self.navigationController?.pushViewController(horseVC, animated: true)
                case .tack:
                    let tackVC = self.loadViewController(Storyboard: .NewListing, ViewController: .NewTackListingVC) as! NewTackListingViewController
                    tackVC.getPlanId = self.planId
                    self.navigationController?.pushViewController(tackVC, animated: true)
                case .equipment:
                    let equipmentVC = self.loadViewController(Storyboard: .NewListing, ViewController: .EquipmentVC) as! EquipmentViewController
                    equipmentVC.getPlanId = self.planId
                    self.navigationController?.pushViewController(equipmentVC, animated: true)
                default:
                    print("no data")
                }
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
}

//profileUpdate.image = imageData
//self.callImageUpdateAPI(params: profileUpdate)
extension NewListingPaymentViewController: IAPPurchasedDelegate{
    func purchasedCallAPI() {
        switch listing {
        case .horse:
            profileUpdate.horsePlanId = self.planId
            self.PaasPlanIDCallAPI(params: profileUpdate)
        case .tack:
            profileUpdate.tackPlanId = self.planId
            self.PaasPlanIDCallAPI(params: profileUpdate)
        case .equipment:
            profileUpdate.equipmentPlanId = self.planId
            self.PaasPlanIDCallAPI(params: profileUpdate)
        default:
            print("no data")
        }
    }
}
