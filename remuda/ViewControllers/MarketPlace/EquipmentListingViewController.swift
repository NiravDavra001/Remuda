//
//  EquipmentListingViewController.swift
//  remuda
//
//  Created by mac on 21/04/21.
//

import UIKit

class EquipmentListingViewController: UIViewController {

    @IBOutlet weak var equipmentDetailsCollectionView: UICollectionView!
    let filterEquipmentsViewModel = EquipmentsFilterViewModel()
    var filterEquipmentsArrDetails : EquipmentsFilterModel?
    var mode : MarketPlaceMode?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        equipmentDetailsCollectionView.delegate = self
        equipmentDetailsCollectionView.dataSource = self
        self.equipmentDetailsCollectionView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        equipmentDetailsCollectionView.register(UINib(nibName: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue)
    }
    override func loadView() {
        super.loadView()
        self.filterEquipmentCallAPI(location: "", condition: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    @objc func refreshTableViewData() {
        self.refreshControl.endRefreshing()
        self.filterEquipmentCallAPI(location: "", condition: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
}
extension EquipmentListingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterEquipmentsArrDetails?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, for: indexPath) as! HorseDetailsCollectionViewCell
        
        let type = filterEquipmentsArrDetails?.data?[indexPath.row].media
        let imgArr : [String] = type?.components(separatedBy: ",") ?? []
        let data = imgArr.first?.components(separatedBy: ".")
        if data?.last == "jpeg" {
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        } else if data?.last == "MOV" {
            let videoData = filterEquipmentsArrDetails?.data?[indexPath.row].thumbnail
            let imgArr : [String] = videoData?.components(separatedBy: ",") ?? []
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        
        cell.lblHorsebreed.text = filterEquipmentsArrDetails?.data?[indexPath.row].title
        let price =  "$" + (filterEquipmentsArrDetails?.data?[indexPath.row].price?.formatUsingAbbrevation() ?? "")
        cell.lblPrice.text = price
        let counedTime = filterEquipmentsArrDetails?.data?[indexPath.row].posttime
        if let convertTime = counedTime{
            cell.lblTime.text =  convertTimeInDaysAgo(interval: Int(convertTime))
        }
        cell.premiumView.isHidden = !(filterEquipmentsArrDetails?.data?[indexPath.row].premium == 1)
        let shares = filterEquipmentsArrDetails?.data?[indexPath.row].shares?.formatUsingAbbrevation()
        cell.lblShares.text = (shares ?? "0") + " shares"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.equipmentDetailsCollectionView.bounds.width / 2 - 4.5 , height : self.equipmentDetailsCollectionView.bounds.width / 2  )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = self.loadViewController(Storyboard: .MarketPlace, ViewController: .HorseDetailsVC) as! HorseDetailsViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.mode = .equipmment
        vc.delegate = self
        vc.currentItemID = filterEquipmentsArrDetails?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
//MARK:- API Calling.
extension EquipmentListingViewController {
    func filterEquipmentCallAPI(location: String,condition:[String],minPrice: Int, maxPrice: Int, keyword: String){
        filterEquipmentsViewModel.data.removeAll()
        if keyword != ""{
            filterEquipmentsViewModel.data["keyword"] = keyword
        }
        if location != ""{
            filterEquipmentsViewModel.data["location"] = location
        }
        filterEquipmentsViewModel.data["condition"] = condition
        if minPrice != 0 && maxPrice != 0{
            filterEquipmentsViewModel.data["minPrice"] = minPrice
            filterEquipmentsViewModel.data["maxPrice"] = maxPrice
        }
        showActivityIndicator(uiView: self.view)
        filterEquipmentsViewModel.getFilterEquipments{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.filterEquipmentsArrDetails = self.filterEquipmentsViewModel.equipmentsFilterData
                if self.filterEquipmentsArrDetails?.data?.count == 0{
                    self.equipmentDetailsCollectionView.setEmptyMessage("There is no matched list available")
                }else{
                    self.equipmentDetailsCollectionView.setEmptyMessage("")
                }
                self.equipmentDetailsCollectionView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension EquipmentListingViewController: ReloadCollectionViewForShareCountDelegate {
    func shareCount() {
        self.filterEquipmentCallAPI(location: "", condition: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
}
