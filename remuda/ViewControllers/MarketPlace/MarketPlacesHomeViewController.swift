//
//  MarketPlacesHomeViewController.swift
//  remuda
//
//  Created by mac on 12/04/21.
//
struct CategoryDataIDValue {
    var id: String?
    var value: String?
}

protocol SearchBymarketplaceModeDelegate {
    func searchBarDetails(searchText: String)
    func btnSearchBarCancel()
}


//MARK: marketplace horse filter
var filterMinPrice: Int?
var filterMaxPrice: Int?
var filterMinAge: Int?
var filterMaxAge: Int?
var filterMinHeight: String?
var filterMaxHeight: String?
var filterMinLTE: Int?
var filterMaxLTE: Int?
var filterHorseByLocation = String()
var filterBreedData = [CategoryDataIDValue]()
var filterDisciplineData = [CategoryDataIDValue]()
var filterColorData = [CategoryDataIDValue]()
var filterGenderData = [CategoryDataIDValue]()

//MARK: marketplace equipment filter
var filterEquipmentMinPrice: Int?
var filterEquipmentMaxPrice: Int?
var filterEquipmentByLocation = String()
var filterConditionData = [CategoryDataIDValue]()

//MARK: marketplace tack filter
var filterTackMinPrice: Int?
var filterTackMaxPrice: Int?
var filterTackByLocation = String()
var filterTackConditionData = [CategoryDataIDValue]()
var filterTackTypeSaddleData = [CategoryDataIDValue]()

import UIKit

class MarketPlacesHomeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var collectionViewMarketPlace: UICollectionView!
    var delegate: ApplyHorseFilterDelegate?
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnListings: UIButton!
    @IBOutlet weak var btnAddPost: UIButton!
    @IBOutlet var mSearchBar: UISearchBar!
    @IBOutlet weak var segmentView: UIView!
    //    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnFilters: UIButton!
    //    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Horses","Equipment","Tack"])
            interfaceSegmented.selectorViewColor = .app_green_color
            interfaceSegmented.selectorTextColor = .app_green_color
        }
    }
    @IBOutlet var filterView: UIView!
    @IBOutlet var lblFilterCount: UIView!
    @IBOutlet var filterCount: UILabel!
    var arrFilterDiscipline = [String]()
    var currentIndex = 0
    var arrDiscipline: [String]?
    var arrBreed: [String]?
    var arrColor: [String]?
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    var arrGender: [String]?
    let refreshControl = UIRefreshControl()
    var isCount = false
    var horseFilterCount = Int()
    var tackFilterCount = Int()
    var equipmentFilterCount = Int()
    
    private lazy var horseListVC: HorsesListViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .HorsesListVC) as! HorsesListViewController
        self.add(asChildViewController: viewController){}
        return viewController
    }()
    private lazy var equipmentListVC: EquipmentListingViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .EquipmentListingVC) as! EquipmentListingViewController
        self.add(asChildViewController: viewController){}
        return viewController
    }()
    private lazy var tackListVC: TackListingViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .TackListingVC) as! TackListingViewController
        self.add(asChildViewController: viewController){}
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFilterCount.isHidden = true
        let categoryDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: HorseCategoryModel.self, key: .storeAllHorseCategory)
        horseFilterData = categoryDetails
        tmpHorseFilterData = categoryDetails
        interfaceSegmented.delegate = self
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: interfaceSegmented.frame.height, width: self.view.frame.width, height: interfaceSegmented.frame.height), buttonTitle: ["Horses","Equipment","Tack"])
        codeSegmented.backgroundColor = .clear
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func btnFilter(_ sender: UIButton) {
        if currentIndex == 0 {
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .MarketPlaceFilterVC) as! MarketPlaceFilterViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else if currentIndex == 1 {
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .MarketPlaceEquipmentFilterVC) as! MarketPlaceEquipmentFilterViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .MarketPlaceTackFilterVC) as! MarketPlaceTackFilterViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        setUpUI()
        setupView()
        
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    
    func setUpUI(){
        lblTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_20))
        btnListings.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTitle.text = "Marketplace"
        btnListings.setTitle("Your Listings", for: .normal)
        mSearchBar.delegate = self
        mSearchBar.searchBarStyle = .minimal
        mSearchBar.searchTextField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        mSearchBar.searchTextField.leftView?.tintColor = .black
        mSearchBar.tintColor = .black
        mSearchBar.placeholder = "Search marketplace..."
        mSearchBar.barTintColor = .selectPhoto_background
        mSearchBar.searchTextField.delegate = self
        mSearchBar.searchTextField.addDoneButtonOnKeyboard()
        
        let approxHeight = 10 * UIScreen.main.bounds.height / 812
        btnFilters.imageEdgeInsets = UIEdgeInsets(top: approxHeight, left: approxHeight, bottom: approxHeight, right: approxHeight)
        filterView.setBorder(1, .button_border_color)
        filterView.setRoundedView()
        
        btnAddPost.setRoundedView()
        btnListings.setBorder(1, .button_border_color)
        btnListings.setRoundedView()
        btnListings.addTarget(self, action: #selector(yourListingTapped), for: .touchUpInside)
        btnAddPost.addTarget(self, action: #selector(addNewListingTapped), for: .touchUpInside)
    }
    
    @objc func addNewListingTapped(){
        self.pushViewController(controllerID: .NewListingCategoryVC, storyBoardID: .NewListing)
    }
    
    @objc func yourListingTapped(){
        self.pushViewController(controllerID: .UserListingsVC, storyBoardID: .MarketPlace)
    }
    
    private func add(asChildViewController viewController: UIViewController, completion: @escaping() -> Void) {
        addChild(viewController)
        segmentView.addSubview(viewController.view)
        viewController.view.frame = segmentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        completion()
    }
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    private func checkFilterCount(category: Int) {
        if category > 0 {
            lblFilterCount.isHidden = false
            widthConstraint.constant = 20 * UIScreen.main.bounds.width / 375
            btnFilters.setImage(UIImage(named: "filtered_icon"), for: .normal)
            filterCount.text = "\(category)"
        }else{
            lblFilterCount.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                self.widthConstraint.constant = 0
            }
            btnFilters.setImage(UIImage(named: "filter_icon"), for: .normal)
            filterCount.text = "\(category)"
        }
    }
    private func updateView() {
        if currentIndex == 0 {
            horseListVC.mode = .horse
            horseListVC.arrFilterDiscipline = self.arrFilterDiscipline
            remove(asChildViewController: equipmentListVC)
            remove(asChildViewController: tackListVC)
            self.checkFilterCount(category: self.horseFilterCount)
            add(asChildViewController: horseListVC){}
        } else if currentIndex == 1 {
            equipmentListVC.mode = .equipmment
            remove(asChildViewController: horseListVC)
            remove(asChildViewController: tackListVC)
            self.checkFilterCount(category: self.equipmentFilterCount)
            add(asChildViewController: equipmentListVC){}
        }
        else{
            tackListVC.mode = .tack
            remove(asChildViewController: horseListVC)
            remove(asChildViewController: equipmentListVC)
            self.checkFilterCount(category: self.tackFilterCount)
            add(asChildViewController: tackListVC){}
        }
    }
    func setupView() {
        updateView()
    }
}
extension MarketPlacesHomeViewController : CustomSegmentedControlDelegate {
    func change(to index: Int) {
        currentIndex = index
        self.updateView()
    }
}

extension MarketPlacesHomeViewController : ApplyHorseFilterDelegate {
    func filterHorseData()
    {
        var count = 0
        if !filterBreedData.isEmpty{
            count += 1
        }
        if !filterDisciplineData.isEmpty{
            count += 1
        }
        if !filterColorData.isEmpty{
            count += 1
        }
        if !filterGenderData.isEmpty{
            count += 1
        }
        if !filterHorseByLocation.isEmpty || filterHorseByLocation != ""{
            count += 1
        }
        if filterMinPrice != nil && filterMaxPrice != nil{
            count += 1
        }
        if filterMinAge != nil && filterMaxAge != nil{
            count += 1
        }
        if filterMinHeight != nil && filterMaxHeight != nil{
            count += 1
        }
        if filterMinLTE != nil && filterMaxLTE != nil{
            count += 1
        }
        if count > 0{
            self.horseFilterCount = count
            lblFilterCount.isHidden = false
            widthConstraint.constant = 20 * UIScreen.main.bounds.width / 375
            btnFilters.setImage(UIImage(named: "filtered_icon"), for: .normal)
            filterCount.text = "\(count)"
        }else{
            self.horseFilterCount = 0
            lblFilterCount.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                self.widthConstraint.constant = 0
            }
            btnFilters.setImage(UIImage(named: "filter_icon"), for: .normal)
            filterCount.text = "\(count)"
        }
        var breedIdArray = [String]()
        _ = filterBreedData.compactMap({
            if $0.id != nil{ breedIdArray.append($0.id ?? "") }
        })
        var disciplineIdArray = [String]()
        _ = filterDisciplineData.compactMap({
            if $0.id != nil{ disciplineIdArray.append($0.id ?? "") }
        })
        var colorIdArray = [String]()
        _ = filterColorData.compactMap({
            if $0.id != nil{ colorIdArray.append($0.id ?? "") }
        })
        var genderIdArray = [String]()
        _ = filterGenderData.compactMap({
            if $0.id != nil{ genderIdArray.append($0.id ?? "") }
        })
        horseListVC.filterHorseCallAPI(discipline: disciplineIdArray, gender: genderIdArray, horse_breed: breedIdArray, minPrice: filterMinPrice ?? 0, maxPrice: filterMaxPrice ?? 0 , color: colorIdArray, minAge: filterMinAge ?? 0, maxAge: filterMaxAge ?? 0, minHeight: filterMinHeight ?? "", maxHeight: filterMaxHeight ?? "", location: filterHorseByLocation, keyword: "")
    }
}
extension MarketPlacesHomeViewController:  ApplyEquipmentFilterDelegate{
    func filterEquipmentData() {
        var count = 0
        if !filterConditionData.isEmpty{
            count += 1
        }
        if !filterEquipmentByLocation.isEmpty || filterEquipmentByLocation != ""{
            count += 1
        }
        if filterEquipmentMinPrice != nil && filterEquipmentMaxPrice != nil{
            count += 1
        }
        if count > 0{
            self.equipmentFilterCount = count
            lblFilterCount.isHidden = false
            widthConstraint.constant = 20 * UIScreen.main.bounds.width / 375
            btnFilters.setImage(UIImage(named: "filtered_icon"), for: .normal)
            filterCount.text = "\(count)"
        }else{
            self.equipmentFilterCount = 0
            lblFilterCount.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                self.widthConstraint.constant = 0
            }
            btnFilters.setImage(UIImage(named: "filter_icon"), for: .normal)
            filterCount.text = "\(count)"
        }
        var conditionIdArray = [String]()
        _ = filterConditionData.compactMap({
            if $0.id != nil{ conditionIdArray.append($0.id ?? "") }
        })
        equipmentListVC.filterEquipmentCallAPI(location: filterEquipmentByLocation, condition: conditionIdArray, minPrice: filterEquipmentMinPrice ?? 0 , maxPrice: filterEquipmentMaxPrice ?? 0, keyword: "")
    }
}
extension MarketPlacesHomeViewController:  ApplyTackFilterDelegate{
    func filterTackData() {
        var count = 0
        if !filterTackConditionData.isEmpty{
            count += 1
        }
        if !filterTackTypeSaddleData.isEmpty{
            count += 1
        }
        if !filterTackByLocation.isEmpty || filterTackByLocation != ""{
            count += 1
        }
        if filterTackMinPrice != nil && filterTackMaxPrice != nil{
            count += 1
        }
        if count > 0{
            self.tackFilterCount = count
            lblFilterCount.isHidden = false
            widthConstraint.constant = 20 * UIScreen.main.bounds.width / 375
            btnFilters.setImage(UIImage(named: "filtered_icon"), for: .normal)
            filterCount.text = "\(count)"
        }else{
            self.tackFilterCount = 0
            lblFilterCount.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
                self.widthConstraint.constant = 0
            }
            btnFilters.setImage(UIImage(named: "filter_icon"), for: .normal)
            filterCount.text = "\(count)"
        }
        var tackConditionIdArray = [String]()
        _ = filterTackConditionData.compactMap({
            if $0.id != nil{ tackConditionIdArray.append($0.id ?? "") }
        })
        var tackTypeSaddleIdArray = [String]()
        _ = filterTackTypeSaddleData.compactMap({
            if $0.id != nil{ tackTypeSaddleIdArray.append($0.id ?? "") }
        })
        tackListVC.filterTackCallAPI(location: filterTackByLocation, condition: tackConditionIdArray, type: tackTypeSaddleIdArray, minPrice: filterTackMinPrice ?? 0, maxPrice: filterTackMaxPrice ?? 0, keyword: "")
    }
}

extension MarketPlacesHomeViewController:  UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch self.currentIndex {
        case 0:
            self.horseListVC.filterHorseCallAPI(discipline: [], gender: [], horse_breed: [], minPrice: 0, maxPrice: 0, color: [], minAge: 0, maxAge: 0, minHeight: "", maxHeight: "", location: "", keyword: searchText)
        case 1:
            self.equipmentListVC.filterEquipmentCallAPI(location: "", condition: [], minPrice: 0, maxPrice: 0, keyword: searchText)
        case 2:
            self.tackListVC.filterTackCallAPI(location: "", condition: [], type: [], minPrice: 0, maxPrice: 0, keyword: searchText)
        default:
            break
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        switch self.currentIndex {
        case 0:
            self.horseListVC.filterHorseCallAPI(discipline: [], gender: [], horse_breed: [], minPrice: 0, maxPrice: 0, color: [], minAge: 0, maxAge: 0, minHeight: "", maxHeight: "", location: "", keyword: "")
        case 1:
            self.equipmentListVC.filterEquipmentCallAPI(location: "", condition: [], minPrice: 0, maxPrice: 0, keyword: "")
        case 2:
            self.tackListVC.filterTackCallAPI(location: "", condition: [], type: [], minPrice: 0, maxPrice: 0, keyword: "")
        default:
            break
        }
    }
}
