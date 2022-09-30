//
//  NewListingCategoryViewController.swift
//  remuda
//
//  Created by Macmini on 26/04/21.
//
enum NewListingCategory: String{
    case horse = "Horse"
    case tack = "Tack"
    case equipment = "Equipment"
}

import UIKit

class NewListingCategoryViewController: UIViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var tableview: UITableView!
    var listingCategory = [ListingCategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButtonTitleHide()
        self.setBackButton()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpUI(){
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.separatorStyle = .none
        self.tableview.register(UINib(nibName: TableCellIdentifiers.NewListingCategoryTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.NewListingCategoryTVCell.rawValue)
        self.tableview.alwaysBounceVertical = false
        lblQuestion.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_24))
    }
    
    func setUpData(){
        listingCategory = [
            ListingCategoryModel(category: .horse),
            ListingCategoryModel(category: .tack),
            ListingCategoryModel(category: .equipment)
        ]
    }
    @IBAction func onTapCloseVC(_ sender: Any) {
        self.popViewController()
    }
    
}

extension NewListingCategoryViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newListingCategoryTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.NewListingCategoryTVCell.rawValue) as? NewListingCategoryTableViewCell
        newListingCategoryTVCell?.selectionStyle = .none
        newListingCategoryTVCell?.lblCategory.text = listingCategory[indexPath.row].category.rawValue
        return newListingCategoryTVCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 * UIScreen.main.bounds.height / 812
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //TODO:- commented code for In-App purchase
        let userDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: ProfileDetailModel.self, key: .storeProfile)
        let paymentVC = loadViewController(Storyboard: .NewListing, ViewController: .NewListingPaymentVC) as! NewListingPaymentViewController
        
        let horseVC = loadViewController(Storyboard: .NewListing, ViewController: .HorseListingVC) as! HorseListingViewController
        let tackVC = loadViewController(Storyboard: .NewListing, ViewController: .NewTackListingVC) as! NewTackListingViewController
        let equipmentVC = loadViewController(Storyboard: .NewListing, ViewController: .EquipmentVC) as! EquipmentViewController
        
        
        switch listingCategory[indexPath.row].category {
        
        case .horse:
            switch userDetails?.data?.horsePlanId {
            case 1:
                horseVC.getPlanId = userDetails?.data?.horsePlanId
                self.navigationController?.pushViewController(horseVC, animated: true)
            case 2:
                horseVC.getPlanId = userDetails?.data?.horsePlanId
                self.navigationController?.pushViewController(horseVC, animated: true)
            default:
                paymentVC.listing = listingCategory[indexPath.row].category
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
//            horseVC.getPlanId = 1
//            self.navigationController?.pushViewController(horseVC, animated: true)
        case .tack:
            switch userDetails?.data?.tackPlanId {
            case 1:
                tackVC.getPlanId = userDetails?.data?.tackPlanId
                self.navigationController?.pushViewController(tackVC, animated: true)
            case 2:
                tackVC.getPlanId = userDetails?.data?.tackPlanId
                self.navigationController?.pushViewController(tackVC, animated: true)
            default:
                paymentVC.listing = listingCategory[indexPath.row].category
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
//            tackVC.getPlanId = 1
//            self.navigationController?.pushViewController(tackVC, animated: true)
        case .equipment:
            switch userDetails?.data?.equipmentPlanId {
            case 1:
                equipmentVC.getPlanId = userDetails?.data?.equipmentPlanId
                self.navigationController?.pushViewController(equipmentVC, animated: true)
            case 2:
                equipmentVC.getPlanId = userDetails?.data?.equipmentPlanId
                self.navigationController?.pushViewController(equipmentVC, animated: true)
            default:
                paymentVC.listing = listingCategory[indexPath.row].category
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
//            equipmentVC.getPlanId = 1
//            self.navigationController?.pushViewController(equipmentVC, animated: true)
        }
    }
}

