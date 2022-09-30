//
//  HorseDetailsViewController.swift
//  remuda
//
//  Created by mac on 14/04/21.
//

import UIKit

enum MarketPlaceMode : String{
    case horse       = "horse"
    case tack        = "tack"
    case equipmment  = "equipment"
}
struct CellDetails{
    var titleOfFeild : String?
    var dataOfFeild : String?
}
protocol ReloadCollectionViewForShareCountDelegate {
    func shareCount()
}
class HorseDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    var shareCountViewModel = NewHorseListViewModel()
    var mode : MarketPlaceMode?
    var viewModel =  ThingDetailsViewModel()
    var listingSaveViewModel = SaveHorseTackEquipmentsViewModel()
    var cellDetails = [CellDetails]()
    var currentItemID = Int()
    var delegate: ReloadCollectionViewForShareCountDelegate?
    var isSaveItemId = 0
    var isUnSaveItemId = 0
    var saveItemId = 0
    var unSaveItemId = 0
    
    var detailViewHidden: Bool = true
    var btnHideViewHidden: Bool = true
    var btnViewHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(true, animated: false)
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
        }
        self.setUpTableView()
        self.currentHorseDetailsCallAPI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will diaappear called")
        
        switch self.mode {
        case .horse:
            self.listingSaveAction(save: "horsesave", unsave: "horseunsave") {
                self.listingSaveCallAPI()
                self.listingSaveViewModel.dict.removeAll()
            }
        case .tack:
            self.listingSaveAction(save: "tacksave", unsave: "tackunsave") {
                self.listingSaveCallAPI()
                self.listingSaveViewModel.dict.removeAll()
            }
        case .equipmment:
            self.listingSaveAction(save: "equipsave", unsave: "equipunsave"){
                self.listingSaveCallAPI()
                self.listingSaveViewModel.dict.removeAll()
            }
        default:
            break
        }
        
    }
    private func setUpUI(){
        self.btnClose.setRoundedView()
        self.btnSave.setRoundedView()
        self.btnShare.setRoundedView()
        self.btnClose.backgroundColor  = .white
        self.btnSave.backgroundColor  = .white
        self.btnShare.backgroundColor  = .white
    }
    private func listingSaveAction(save: String, unsave: String, completion: @escaping () -> Void) {
        if isSaveItemId != saveItemId{
            if saveItemId != 0{
                print("save id:",saveItemId)
                self.listingSaveViewModel.dict[save] = "\(saveItemId)"
            }
        }
        if isUnSaveItemId != unSaveItemId{
            if unSaveItemId != 0{
                print("unsave id:",unSaveItemId)
                self.listingSaveViewModel.dict[unsave] = "\(unSaveItemId)"
            }
        }
        
        completion()
    }
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: TableCellIdentifiers.HorseImagesTitleTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HorseImagesTitleTVCell.rawValue)
        self.tableView.register(UINib(nibName: TableCellIdentifiers.HorseOwnerDetailsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HorseOwnerDetailsTVCell.rawValue)
        self.tableView.register(UINib(nibName: TableCellIdentifiers.HorseDetailsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HorseDetailsTVCell.rawValue)
        self.tableView.register(UINib(nibName: TableCellIdentifiers.ViewContactInfoTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.ViewContactInfoTVCell.rawValue)
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = false
        self.popViewController()
        self.delegate?.shareCount()
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        switch self.mode {
        case .horse:
            if self.viewModel.horseDetails?.data?.isSave == 1{
                if let id = self.viewModel.horseDetails?.data?.id {
                    self.saveItemId = 0
                    self.unSaveItemId = id
                }
                self.viewModel.horseDetails?.data?.isSave = 0
                self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                
            }else{
                if let id = self.viewModel.horseDetails?.data?.id {
                    self.saveItemId = id
                    self.unSaveItemId = 0
                }
                self.viewModel.horseDetails?.data?.isSave = 1
                self.btnSave.tintColor = .postLike_red_color
                self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
            }
        case .tack:
            if self.viewModel.tackDetails?.data?.isSave == 1{
                if let id = self.viewModel.tackDetails?.data?.id {
                    self.saveItemId = 0
                    self.unSaveItemId = id
                }
                self.viewModel.tackDetails?.data?.isSave = 0
                self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                
            }else{
                if let id = self.viewModel.tackDetails?.data?.id {
                    self.saveItemId = id
                    self.unSaveItemId = 0
                }
                self.viewModel.tackDetails?.data?.isSave = 1
                self.btnSave.tintColor = .postLike_red_color
                self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
            }
        case .equipmment:
            if self.viewModel.equipmentDetails?.data?.isSave == 1{
                if let id = self.viewModel.equipmentDetails?.data?.id {
                    self.saveItemId = 0
                    self.unSaveItemId = id
                }
                self.viewModel.equipmentDetails?.data?.isSave = 0
                self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                
            }else{
                if let id = self.viewModel.equipmentDetails?.data?.id {
                    self.saveItemId = id
                    self.unSaveItemId = 0
                }
                self.viewModel.equipmentDetails?.data?.isSave = 1
                self.btnSave.tintColor = .postLike_red_color
                self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
            }
        default:
            break
        }
        
    }
    @IBAction func btnShareAction(_ sender: Any) {
        switch self.mode {
        case .horse:
            self.shareCountAPICall(mode: "horseid", currentItemID: self.currentItemID) {
                self.showShareActivity(url: "remuda://remuda.com/horse/\(self.currentItemID)")
            }
        case .equipmment:
            self.shareCountAPICall(mode: "equipid", currentItemID: self.currentItemID) {
                self.showShareActivity(url: "remuda://remuda.com/equipmment/\(self.currentItemID)")
            }
        case .tack:
            self.shareCountAPICall(mode: "tackid", currentItemID: self.currentItemID) {
                self.showShareActivity(url: "remuda://remuda.com/tack/\(self.currentItemID)")
            }
        default:
            return
        }
    }
}
//MARK:- TableView Datasource and Delegate methods
extension HorseDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.mode {
        case .horse:
            return 15
        case .equipmment:
            return 5
        case .tack:
            return 7
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: HorseCategoryModel.self, key: .storeAllHorseCategory)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HorseImagesTitleTVCell.rawValue, for: indexPath) as! HorseImagesTitleTableViewCell
            cell.selectionStyle = .none
            if self.mode == .horse {
                let imgUrl = viewModel.horseDetails?.data?.media
                let imgArr : [String] = imgUrl?.components(separatedBy: ",") ?? []
                cell.imageURL = imgArr
                cell.imageName = viewModel.horseDetails?.data?.thumbnail ?? ""
                cell.playVideoDelegate = self
            }
            else if self.mode == .equipmment {
                let imgUrl = viewModel.equipmentDetails?.data?.media
                let imgArr : [String] = imgUrl?.components(separatedBy: ",") ?? []
                cell.imageURL = imgArr
                cell.imageName = viewModel.equipmentDetails?.data?.thumbnail ?? ""
                cell.playVideoDelegate = self
            }
            else{
                let imgUrl = viewModel.tackDetails?.data?.media
                let imgArr : [String] = imgUrl?.components(separatedBy: ",") ?? []
                cell.imageURL = imgArr
                cell.imageName = viewModel.tackDetails?.data?.thumbnail ?? ""
                cell.playVideoDelegate = self
            }
            cell.collectionView.reloadData()
            return cell
        }
        
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HorseOwnerDetailsTVCell.rawValue, for: indexPath) as! HorseOwnerDetailsTableViewCell
            
            cell.selectionStyle = .none
            if self.mode == .horse {
                cell.lblHorseBreed.text = viewModel.horseDetails?.data?.title
                let price =  "$" + String((viewModel.horseDetails?.data?.price ?? 0))
                cell.lblPrice.text = price
                cell.lblHorseDescription.text = viewModel.horseDetails?.data?.descriptionField
                let imgUrl = viewModel.horseDetails?.data?.image
                cell.imgUserPic.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                cell.lblUserName.text = "\(viewModel.horseDetails?.data?.firstName ?? "") \(viewModel.horseDetails?.data?.lastName ?? "")"
                cell.lblUserCity.text = viewModel.horseDetails?.data?.location
            }
            else if self.mode == .equipmment {
                cell.lblHorseBreed.text = viewModel.equipmentDetails?.data?.title
                let price =  "$" + String((viewModel.equipmentDetails?.data?.price ?? 0))
                cell.lblPrice.text = price
                cell.lblHorseDescription.text = viewModel.equipmentDetails?.data?.descriptionField
                cell.lblHorseDescription.text = viewModel.equipmentDetails?.data?.descriptionField
                let imgUrl = viewModel.equipmentDetails?.data?.image
                cell.imgUserPic.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                cell.lblUserName.text = "\(viewModel.equipmentDetails?.data?.firstName ?? "") \(viewModel.equipmentDetails?.data?.lastName ?? "")"
                cell.lblUserCity.text = viewModel.equipmentDetails?.data?.location
            }
            else{
                cell.lblHorseBreed.text = viewModel.tackDetails?.data?.title
                let price =  "$" + String((viewModel.tackDetails?.data?.price ?? 0))
                cell.lblPrice.text = price
                cell.lblHorseDescription.text = viewModel.tackDetails?.data?.descriptionField
                
                cell.lblHorseDescription.text = viewModel.tackDetails?.data?.descriptionField
                cell.lblHorseDescription.text = viewModel.tackDetails?.data?.descriptionField
                let imgUrl = viewModel.tackDetails?.data?.image
                cell.imgUserPic.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                cell.lblUserName.text = "\(viewModel.tackDetails?.data?.firstName ?? "") \(viewModel.tackDetails?.data?.lastName ?? "")"
                cell.lblUserCity.text = viewModel.tackDetails?.data?.location
            }
            return cell
        }
        
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HorseDetailsTVCell.rawValue, for: indexPath) as! HorseDetailsTableViewCell
            cell.selectionStyle = .none
            cell.lblTItle.textColor = .black
            cell.lblTItle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_18))
            cell.sepratorView.backgroundColor = .systemBackground
            if self.mode == .horse {
                cell.setTitleAndDetails(title: "Details:", details: "")
            }
            else if self.mode == .equipmment {
                cell.setTitleAndDetails(title: "Details:", details: "")
            }
            else  {
                cell.setTitleAndDetails(title: "Details:", details: "")
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HorseDetailsTVCell.rawValue, for: indexPath) as! HorseDetailsTableViewCell
            cell.selectionStyle = .none
            if indexPath.row == 3 {
                if self.mode == .horse {
                    _ = categoryDetails?.data?.breed.map({ (arr) in
                        arr.map { (breed) in
                            if breed.id == viewModel.horseDetails?.data?.horseBreed{
                                cell.setTitleAndDetails(title: "Breed:", details: breed.value ?? "")
                            }
                        }
                    })
                }
                else if self.mode == .equipmment {
                    _ = categoryDetails?.data?.condition.map({ (arr) in
                        arr.map { (condition) in
                            if condition.id == viewModel.equipmentDetails?.data?.conditions{
                                cell.setTitleAndDetails(title: "Condtion:", details: condition.value ?? "")
                            }
                        }
                    })
                    
                }
                else  {
                    _ = categoryDetails?.data?.type.map({ (arr) in
                        arr.map { (type) in
                            if type.id == viewModel.tackDetails?.data?.type{
                                cell.setTitleAndDetails(title: "Type:", details: type.value ?? "")
                            }
                        }
                    })
                }
            }
            else if indexPath.row == 4 {
                if self.mode == .horse {
                    cell.setTitleAndDetails(title: "Age:", details: String(viewModel.horseDetails?.data?.age ?? 0))
                }
                else if self.mode == .equipmment {
                    let contactCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.ViewContactInfoTVCell.rawValue, for: indexPath) as! ViewContactInfoTableViewCell
                    contactCell.detailsView.isHidden = self.detailViewHidden
                    contactCell.btnView.isHidden = self.btnViewHidden
                    contactCell.btnHideView.isHidden = self.btnHideViewHidden
                    contactCell.indexPath = indexPath
                    contactCell.selectionStyle = .none
                    contactCell.delegate = self
                    let imgUrl = viewModel.equipmentDetails?.data?.image
                    contactCell.imguserProfile.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                    let fullName = "\(viewModel.equipmentDetails?.data?.firstName ?? "") \(viewModel.equipmentDetails?.data?.lastName ?? "")"
                    let text = NSMutableAttributedString()
                    text.append(NSAttributedString(string: "Contact Info for ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
                    text.append(NSAttributedString(string: fullName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.app_green_color]))
                    contactCell.lblTItleInfo.attributedText = text
                    contactCell.lblAddress.text = viewModel.equipmentDetails?.data?.location
                    contactCell.lblContactNumber.text = viewModel.equipmentDetails?.data?.mobile
                    contactCell.lblEmailAddress.text = viewModel.equipmentDetails?.data?.email
                    return contactCell
                }
                else{
                    _ = categoryDetails?.data?.saddle.map({ (arr) in
                        arr.map { (saddle) in
                            if saddle.id == viewModel.tackDetails?.data?.saddles{
                                cell.setTitleAndDetails(title: "Saddles:", details: saddle.value ?? "")
                            }
                        }
                    })
                }
                
            }
            else if indexPath.row == 5 {
                if self.mode == .horse {
                    _ = categoryDetails?.data?.color.map({ (arr) in
                        arr.map { (color) in
                            if color.id == viewModel.horseDetails?.data?.color{
                                cell.setTitleAndDetails(title: "Color:", details: color.value ?? "")
                            }
                        }
                    })
                }else if self.mode == .tack{
                    _ = categoryDetails?.data?.tackCondition.map({ (arr) in
                        arr.map { (tackCondition) in
                            if tackCondition.id != nil{
                                if tackCondition.id == viewModel.tackDetails?.data?.conditions{
                                    cell.setTitleAndDetails(title: "Condtion:", details: tackCondition.value ?? "")
                                }
                            }
                        }
                    })
                }
            }
            else if indexPath.row == 6 {
                if self.mode == .horse {
                    cell.setTitleAndDetails(title: "Height:", details: viewModel.horseDetails?.data?.height ?? "")
                }
                else {
                    let contactCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.ViewContactInfoTVCell.rawValue, for: indexPath) as! ViewContactInfoTableViewCell
                    contactCell.detailsView.isHidden = self.detailViewHidden
                    contactCell.btnView.isHidden = self.btnViewHidden
                    contactCell.btnHideView.isHidden = self.btnHideViewHidden
                    contactCell.indexPath = indexPath
                    contactCell.selectionStyle = .none
                    contactCell.delegate = self
                    let imgUrl = viewModel.tackDetails?.data?.image
                    contactCell.imguserProfile.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                    let fullName = "\(viewModel.tackDetails?.data?.firstName ?? "") \(viewModel.tackDetails?.data?.lastName ?? "")"
                    let text = NSMutableAttributedString()
                    text.append(NSAttributedString(string: "Contact Info for ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
                    text.append(NSAttributedString(string: fullName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.app_green_color]))
                    contactCell.lblTItleInfo.attributedText = text
                    contactCell.lblAddress.text = viewModel.tackDetails?.data?.location
                    contactCell.lblContactNumber.text = viewModel.tackDetails?.data?.mobile
                    contactCell.lblEmailAddress.text = viewModel.tackDetails?.data?.email
                    return contactCell
                }
            }
            else if indexPath.row == 7 {
                _ = categoryDetails?.data?.discipline.map({ (arr) in
                    arr.map { (discipline) in
                        if discipline.id == viewModel.horseDetails?.data?.discipline{
                            cell.setTitleAndDetails(title: "Discipline:", details: discipline.value ?? "")
                        }
                    }
                })
            }
            else if indexPath.row == 8 {
                cell.setTitleAndDetails(title: "Pedigree:", details: "View Pedigree Tree")
            }
            else if indexPath.row == 9 {
                cell.setTitleAndDetails(title: "Significant Name:", details: viewModel.horseDetails?.data?.papers ?? "")
            }
            else if indexPath.row == 10 {
                cell.setTitleAndDetails(title: "Ability Level:", details: viewModel.horseDetails?.data?.abilityLevel ?? "")
            }
            else if indexPath.row == 11 {
                cell.setTitleAndDetails(title: "Breeding Stock:", details: viewModel.horseDetails?.data?.breedingStock ?? "")
            }
            else if indexPath.row == 12 {
                cell.setTitleAndDetails(title: "Radiographs:", details: viewModel.horseDetails?.data?.radiographs ?? "")
            }
            else if indexPath.row == 13 {
                cell.lblTItle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
                cell.lblTItle.textColor = .button_gray_color
                _ = categoryDetails?.data?.gender.map({ (arr) in
                    arr.map { (gender) in
                        if gender.id == viewModel.horseDetails?.data?.gender{
                            cell.setTitleAndDetails(title: "Gender:", details: gender.value ?? "")
                        }
                    }
                })
            }
            else if indexPath.row == 14 {
                let contactCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.ViewContactInfoTVCell.rawValue, for: indexPath) as! ViewContactInfoTableViewCell
                contactCell.detailsView.isHidden = self.detailViewHidden
                contactCell.btnView.isHidden = self.btnViewHidden
                contactCell.btnHideView.isHidden = self.btnHideViewHidden
                contactCell.indexPath = indexPath
                contactCell.selectionStyle = .none
                contactCell.delegate = self
                let imgUrl = viewModel.horseDetails?.data?.image
                contactCell.imguserProfile.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
                let fullName = "\(viewModel.horseDetails?.data?.firstName ?? "") \(viewModel.horseDetails?.data?.lastName ?? "")"
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: "Contact Info for ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
                text.append(NSAttributedString(string: fullName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.app_green_color]))
                contactCell.lblTItleInfo.attributedText = text
                contactCell.lblAddress.text = viewModel.horseDetails?.data?.location
                contactCell.lblContactNumber.text = viewModel.horseDetails?.data?.mobile
                contactCell.lblEmailAddress.text = viewModel.horseDetails?.data?.email
                return contactCell
            }
            if indexPath.row == 8 {
                cell.btnPedigree.isHidden = false
            }else{
                cell.btnPedigree.isHidden = true
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8 {
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .HorseChildVC) as! HorseChildViewController
            vc.horseId = self.currentItemID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 375 * UIScreen.main.bounds.height / 812
        default:
            return UITableView.automaticDimension
        }
    }
}
extension HorseDetailsViewController : ViewContactInfoTableViewCellDelegate{
    func showContactInfo(indexPath: IndexPath) {
        if !(self.btnViewHidden){
            self.detailViewHidden = false
            self.btnViewHidden = true
            self.btnHideViewHidden = false
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }else{
            self.detailViewHidden = true
            self.btnViewHidden = false
            self.btnHideViewHidden = true
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
//MARK:- API calling.
extension HorseDetailsViewController {
    func currentHorseDetailsCallAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.getThingsDetails(thingID: currentItemID , mode: mode ?? .horse) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                switch self.mode {
                case .horse:
                    if self.viewModel.horseDetails?.data?.isSave == 1{
                        if let id = self.viewModel.horseDetails?.data?.id {
                            self.isSaveItemId = id
                        }
                        self.btnSave.tintColor = .postLike_red_color
                        self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
                    }else{
                        if let id = self.viewModel.horseDetails?.data?.id {
                            self.isUnSaveItemId = id
                        }
                        self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                    }
                case .tack:
                    if self.viewModel.tackDetails?.data?.isSave == 1{
                        self.btnSave.tintColor = .postLike_red_color
                        self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
                        if let id = self.viewModel.tackDetails?.data?.id {
                            self.isSaveItemId = id
                        }
                    }else{
                        self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                        if let id = self.viewModel.tackDetails?.data?.id {
                            self.isUnSaveItemId = id
                        }
                    }
                case .equipmment:
                    if self.viewModel.equipmentDetails?.data?.isSave == 1{
                        self.btnSave.tintColor = .postLike_red_color
                        self.btnSave.setImage(UIImage(named: "ic_saved_bookmark"), for: .normal)
                        if let id = self.viewModel.equipmentDetails?.data?.id {
                            self.isSaveItemId = id
                        }
                    }else{
                        self.btnSave.setImage(UIImage(named: "bookmark_icon"), for: .normal)
                        if let id = self.viewModel.equipmentDetails?.data?.id {
                            self.isUnSaveItemId = id
                        }
                    }
                default:
                    break
                }
                self.tableView.reloadData()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    func listingSaveCallAPI(){
        showActivityIndicator(uiView: self.view)
        listingSaveViewModel.saveHorseTackEquipmentsAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    func shareCountAPICall(mode: String,currentItemID: Int,completion: @escaping () -> ()) {
        shareCountViewModel.shareCountAPI(params: [mode : currentItemID]) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                completion()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- Play video using AVPlayer.
extension HorseDetailsViewController: HomeFeedDelegate{
    func playSelectedVideo(url: String) {
        playVideo(videoUrl: url)
    }
    func btnseeMoreAction(indexPath: IndexPath) {
    }
}
