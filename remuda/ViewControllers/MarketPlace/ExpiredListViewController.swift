//
//  ExpiredListViewController.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//

import UIKit

class ExpiredListViewController: UIViewController {

    @IBOutlet var expiredDetailTableView: UITableView!
    var mode : ListingMode?
    let getExpiredListViewModel = ListingsViewModel()
    var expiredListingArrDetails : ListingsModel?
    var tmpExpiredListingArrDetails: [ListingData]?
    
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
        expiredDetailTableView.reloadData()
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    
    func setUpUI(){
    }
    func setTableView() {
        self.expiredDetailTableView.dataSource = self
        self.expiredDetailTableView.delegate = self
        self.expiredDetailTableView.separatorStyle = .none
        self.expiredDetailTableView.register(UINib(nibName: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue)
    }
}

extension ExpiredListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpExpiredListingArrDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marketPlaceListingTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.MarketPlaceListingTVCell.rawValue) as! MarketPlaceListingTableViewCell
        marketPlaceListingTVCell.selectionStyle = .none
        marketPlaceListingTVCell.indexPath = indexPath
        marketPlaceListingTVCell.delegate = self
        marketPlaceListingTVCell.lblListingTitle.text = tmpExpiredListingArrDetails?[indexPath.row].title
        if let price = tmpExpiredListingArrDetails?[indexPath.row].price {
            marketPlaceListingTVCell.lblListingPrice.text = "$" + String(price)
        }
        let imageData = tmpExpiredListingArrDetails?[indexPath.row].media
        marketPlaceListingTVCell.imgView.sd_setImage(with: URL(string: imageData ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        var postTime = tmpExpiredListingArrDetails?[indexPath.row].createdAt
        postTime?.removeLast(5)
        if let countedTime = postTime{
            marketPlaceListingTVCell.lblListingUploadedTime.text = countedTime.timeInterval(timeAgo: countedTime)
        }
        marketPlaceListingTVCell.btnListing.setTitle("Re-List", for: .normal)
        return marketPlaceListingTVCell
    }
}
//MARK:- API calling
extension ExpiredListViewController {
    func getMarketplaceListingAPI(){
        showActivityIndicator(uiView: self.view)
        getExpiredListViewModel.getMarketplaceListingsList { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.expiredListingArrDetails = self.getExpiredListViewModel.listingsList
                self.tmpExpiredListingArrDetails = self.expiredListingArrDetails?.data?.filter{$0.status == 2}
                if self.tmpExpiredListingArrDetails?.count == 0{
                    self.expiredDetailTableView.setEmptyMessage("There is no expired list")
                }else{
                    self.expiredDetailTableView.setEmptyMessage("")
                }
                self.expiredDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func changeListingStatusAPI(){
        showActivityIndicator(uiView: self.view)
        getExpiredListViewModel.changeListingsStatus { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.getMarketplaceListingAPI()
                self.expiredDetailTableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- MarketplaceListingsActionDelegate method
extension ExpiredListViewController: MarketplaceListingsActionDelegate {
    func btnListingsAction(indexPath: IndexPath) {
        self.getExpiredListViewModel.dict.removeAll()
        switch tmpExpiredListingArrDetails?[indexPath.row].types {
        case 1:
            if let id = tmpExpiredListingArrDetails?[indexPath.row].id {
                self.getExpiredListViewModel.dict["horseid"] = id
                self.getExpiredListViewModel.dict["status"] = 1
            }
        case 2:
            if let id = tmpExpiredListingArrDetails?[indexPath.row].id {
                self.getExpiredListViewModel.dict["tackid"] = id
                self.getExpiredListViewModel.dict["status"] = 1
            }
        case 3:
            if let id = tmpExpiredListingArrDetails?[indexPath.row].id {
                self.getExpiredListViewModel.dict["equipid"] = id
                self.getExpiredListViewModel.dict["status"] = 1
            }
        default:
            break
        }
        self.changeListingStatusAPI()
    }
}
