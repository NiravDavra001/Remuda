//
//  SellingListViewController.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//

import UIKit

class SellingListViewController: UIViewController {
    //type 1 - horse, type 2= equipment, type-3 = tack
    //status -1 =selling, status-2 = expired, status-3=sold
    @IBOutlet var sellingDetailTableView: UITableView!
    var mode : ListingMode?
    let getSellingListViewModel = ListingsViewModel()
    var sellingListingArrDetails : ListingsModel?
    var tmpSellingListingArrDetails: [ListingData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMarketplaceListingAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.sellingDetailTableView.reloadData()
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    func setUpUI(){
    }
    
    func setTableView() {
        self.sellingDetailTableView.dataSource = self
        self.sellingDetailTableView.delegate = self
        self.sellingDetailTableView.separatorStyle = .none
        self.sellingDetailTableView.register(UINib(nibName: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue)
    }
}


extension SellingListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpSellingListingArrDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketPlaceListingTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue) as! MarketPlaceListingTableViewCell
        marketPlaceListingTVCell.selectionStyle = .none
        marketPlaceListingTVCell.indexPath = indexPath
        marketPlaceListingTVCell.delegate = self
        marketPlaceListingTVCell.lblListingTitle.text = tmpSellingListingArrDetails?[indexPath.row].title
        if let price = tmpSellingListingArrDetails?[indexPath.row].price {
            marketPlaceListingTVCell.lblListingPrice.text = "$" + String(price)
        }
        let imageData = tmpSellingListingArrDetails?[indexPath.row].media
        marketPlaceListingTVCell.imgView.sd_setImage(with: URL(string: imageData ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        var postTime = tmpSellingListingArrDetails?[indexPath.row].createdAt
        postTime?.removeLast(5)
        if let countedTime = postTime{
            marketPlaceListingTVCell.lblListingUploadedTime.text = countedTime.timeInterval(timeAgo: countedTime)
        }
        marketPlaceListingTVCell.btnListing.setTitle("Mark as Sold", for: .normal)
        return marketPlaceListingTVCell
    } 
}
//MARK:- API calling
extension SellingListViewController {
    func getMarketplaceListingAPI(){
        showActivityIndicator(uiView: self.view)
        getSellingListViewModel.getMarketplaceListingsList { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.sellingListingArrDetails = self.getSellingListViewModel.listingsList
                self.tmpSellingListingArrDetails = self.sellingListingArrDetails?.data?.filter{$0.status == 1}
                if self.tmpSellingListingArrDetails?.count == 0{
                    self.sellingDetailTableView.setEmptyMessage("There is no selling list to sell things go to marketplace and click on + ")
                }else{
                    self.sellingDetailTableView.setEmptyMessage("")
                }
                self.sellingDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func changeListingStatusAPI(){
        showActivityIndicator(uiView: self.view)
        getSellingListViewModel.changeListingsStatus { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.getMarketplaceListingAPI()
                self.sellingDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- MarketplaceListingsActionDelegate method
extension SellingListViewController: MarketplaceListingsActionDelegate {
    func btnListingsAction(indexPath: IndexPath) {
        self.getSellingListViewModel.dict.removeAll()
        
        switch tmpSellingListingArrDetails?[indexPath.row].types {
        case 1:
            if let id = tmpSellingListingArrDetails?[indexPath.row].id {
                self.getSellingListViewModel.dict["horseid"] = id
                self.getSellingListViewModel.dict["status"] = 3
            }
        case 2:
            if let id = tmpSellingListingArrDetails?[indexPath.row].id {
                self.getSellingListViewModel.dict["tackid"] = id
                self.getSellingListViewModel.dict["status"] = 3
            }
        case 3:
            if let id = tmpSellingListingArrDetails?[indexPath.row].id {
                self.getSellingListViewModel.dict["equipid"] = id
                self.getSellingListViewModel.dict["status"] = 3
            }
        default:
            break
        }
        self.changeListingStatusAPI()
    }
}
