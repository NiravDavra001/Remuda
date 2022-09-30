//
//  TackListingViewController.swift
//  remuda
//
//  Created by mac on 21/04/21.
//

import UIKit

class TackListingViewController: UIViewController {
    
    @IBOutlet weak var tackDetailsCollectionView: UICollectionView!
    let filterTackViewModel = TacksFilterViewModel()
    var filterTackArrDetails : TacksFilterModel?
    var mode : MarketPlaceMode?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tackDetailsCollectionView.delegate = self
        tackDetailsCollectionView.dataSource = self
        self.tackDetailsCollectionView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        tackDetailsCollectionView.register(UINib(nibName: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue)
    }
    override func loadView() {
        super.loadView()
        self.filterTackCallAPI(location: "", condition: [], type: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    
    @objc func refreshTableViewData() {
        self.refreshControl.endRefreshing()
        self.filterTackCallAPI(location: "", condition: [], type: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
}
extension TackListingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterTackArrDetails?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, for: indexPath) as! HorseDetailsCollectionViewCell
        
        let type = filterTackArrDetails?.data?[indexPath.row].media
        let imgArr : [String] = type?.components(separatedBy: ",") ?? []
        let data = imgArr.first?.components(separatedBy: ".")
        if data?.last == "jpeg" {
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        } else if data?.last == "MOV" {
            let videoData = filterTackArrDetails?.data?[indexPath.row].thumbnail
            let imgArr : [String] = videoData?.components(separatedBy: ",") ?? []
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        cell.lblHorsebreed.text = filterTackArrDetails?.data?[indexPath.row].title
        let price =  "$" + (filterTackArrDetails?.data?[indexPath.row].price?.formatUsingAbbrevation() ?? "")
        cell.lblPrice.text = price
        let counedTime = filterTackArrDetails?.data?[indexPath.row].posttime
        if let convertTime = counedTime{
            cell.lblTime.text =  convertTimeInDaysAgo(interval: Int(convertTime))
        }
        cell.premiumView.isHidden = !(filterTackArrDetails?.data?[indexPath.row].premium == 1)
        let shares = filterTackArrDetails?.data?[indexPath.row].shares?.formatUsingAbbrevation()
        cell.lblShares.text = (shares ?? "0") + " shares"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tackDetailsCollectionView.bounds.width / 2 - 4.5, height : self.tackDetailsCollectionView.bounds.width / 2  )
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
        vc.mode = .tack
        vc.delegate = self
        vc.currentItemID = filterTackArrDetails?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TackListingViewController {
    func filterTackCallAPI(location: String, condition:[String], type:[String], minPrice: Int, maxPrice: Int, keyword: String){
        filterTackViewModel.data.removeAll()
        if keyword != ""{
            filterTackViewModel.data["keyword"] = keyword
        }
        if location != ""{
            filterTackViewModel.data["location"] = location
        }
        filterTackViewModel.data["condition"] = condition
        filterTackViewModel.data["saddles"] = type
        filterTackViewModel.data["type"] = type
        if minPrice != 0 && maxPrice != 0{
            filterTackViewModel.data["minPrice"] = minPrice
            filterTackViewModel.data["maxPrice"] = maxPrice
        }
        showActivityIndicator(uiView: self.view)
        filterTackViewModel.getFilterTack{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.filterTackArrDetails = self.filterTackViewModel.tacksFilterData
                if self.filterTackArrDetails?.data?.count == 0{
                    self.tackDetailsCollectionView.setEmptyMessage("There is no matched list available")
                }else{
                    self.tackDetailsCollectionView.setEmptyMessage("")
                }
                self.tackDetailsCollectionView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension TackListingViewController: ReloadCollectionViewForShareCountDelegate {
    func shareCount() {
        self.filterTackCallAPI(location: "", condition: [], type: [], minPrice: 0, maxPrice: 0, keyword: "")
    }
}
