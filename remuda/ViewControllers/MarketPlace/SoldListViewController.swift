//
//  SoldListViewController.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//

import UIKit

class SoldListViewController: UIViewController {

    @IBOutlet var soldDetailTableView: UITableView!
    var mode : ListingMode?
    let getSoldListViewModel = ListingsViewModel()
    var soldListingArrDetails : ListingsModel?
    var tmpSoldListingArrDetails: [ListingData]?
    
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
        self.soldDetailTableView.reloadData()
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    func setUpUI(){
    }
    func setTableView() {
        self.soldDetailTableView.dataSource = self
        self.soldDetailTableView.delegate = self
        self.soldDetailTableView.separatorStyle = .none
        self.soldDetailTableView.register(UINib(nibName: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue)
    }
}

extension SoldListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpSoldListingArrDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketPlaceListingTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue) as! MarketPlaceListingTableViewCell
        marketPlaceListingTVCell.selectionStyle = .none
        marketPlaceListingTVCell.delegate = self
        marketPlaceListingTVCell.indexPath = indexPath
        marketPlaceListingTVCell.lblListingTitle.text = tmpSoldListingArrDetails?[indexPath.row].title
        if let price = tmpSoldListingArrDetails?[indexPath.row].price {
            marketPlaceListingTVCell.lblListingPrice.text = "$" + String(price)
        }
        let imageData = tmpSoldListingArrDetails?[indexPath.row].media
        marketPlaceListingTVCell.imgView.sd_setImage(with: URL(string: imageData ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        var postTime = tmpSoldListingArrDetails?[indexPath.row].createdAt
        postTime?.removeLast(5)
        if let countedTime = postTime{
            marketPlaceListingTVCell.lblListingUploadedTime.text = countedTime.timeInterval(timeAgo: countedTime)
        }
        marketPlaceListingTVCell.btnListing.setTitle("Mark as Available", for: .normal)
        return marketPlaceListingTVCell
    }
}
//MARK:- API calling
extension SoldListViewController {
    func getMarketplaceListingAPI(){
        showActivityIndicator(uiView: self.view)
        getSoldListViewModel.getMarketplaceListingsList { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.soldListingArrDetails = self.getSoldListViewModel.listingsList
                self.tmpSoldListingArrDetails = self.soldListingArrDetails?.data?.filter{$0.status == 3}
                if self.tmpSoldListingArrDetails?.count == 0{
                    self.soldDetailTableView.setEmptyMessage("There is no sold list")
                }else{
                    self.soldDetailTableView.setEmptyMessage("")
                }
                self.soldDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func changeListingStatusAPI(){
        showActivityIndicator(uiView: self.view)
        getSoldListViewModel.changeListingsStatus { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.getMarketplaceListingAPI()
                self.soldDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- MarketplaceListingsActionDelegate method
extension SoldListViewController: MarketplaceListingsActionDelegate {
    func btnListingsAction(indexPath: IndexPath) {
        self.getSoldListViewModel.dict.removeAll()
        switch tmpSoldListingArrDetails?[indexPath.row].types {
        case 1:
            if let id = tmpSoldListingArrDetails?[indexPath.row].id {
                self.getSoldListViewModel.dict["horseid"] = id
                self.getSoldListViewModel.dict["status"] = 1
            }
        case 2:
            if let id = tmpSoldListingArrDetails?[indexPath.row].id {
                self.getSoldListViewModel.dict["tackid"] = id
                self.getSoldListViewModel.dict["status"] = 1
            }
        case 3:
            if let id = tmpSoldListingArrDetails?[indexPath.row].id {
                self.getSoldListViewModel.dict["equipid"] = id
                self.getSoldListViewModel.dict["status"] = 1
            }
        default:
            break
        }
        self.changeListingStatusAPI()
    }
}
