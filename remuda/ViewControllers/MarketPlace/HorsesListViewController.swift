//
//  HorsesListViewController.swift
//  remuda
//
//  Created by mac on 21/04/21.
//

import UIKit
import SDWebImage

class HorsesListViewController: UIViewController {
    
    @IBOutlet weak var horseDetailsCollectionView: UICollectionView!
    
    let filterHorseViewModel = HorseFilterViewModel()
    var filterHorseArrDetails : HorseFilterModel?
    var searchHorseArrDetails = [FilterHorse]()
    var mode : MarketPlaceMode?
    var arrFilterDiscipline = [String]()
    var arrDiscipline = String()
    var isSearching: Bool = false
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.horseDetailsCollectionView.delegate = self
        self.horseDetailsCollectionView.dataSource = self
        self.horseDetailsCollectionView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        self.horseDetailsCollectionView.register(UINib(nibName: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue)
    }
    override func loadView() {
        super.loadView()
        self.filterHorseCallAPI(discipline: [], gender: [], horse_breed: [], minPrice: 0, maxPrice: 0, color: [], minAge: 0, maxAge: 0, minHeight: "", maxHeight: "", location: "", keyword: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    @objc func refreshTableViewData() {
        self.refreshControl.endRefreshing()
        self.filterHorseCallAPI(discipline: [], gender: [], horse_breed: [], minPrice: 0, maxPrice: 0, color: [], minAge: 0, maxAge: 0, minHeight: "", maxHeight: "", location: "", keyword: "")
    }
}

extension HorsesListViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterHorseArrDetails?.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.HorseDetailsCVCell.rawValue, for: indexPath) as! HorseDetailsCollectionViewCell
        
        let type = filterHorseArrDetails?.data?[indexPath.row].media
        let imgArr : [String] = type?.components(separatedBy: ",") ?? []
        let data = imgArr.first?.components(separatedBy: ".")
        if data?.last == "jpeg" {
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        } else if data?.last == "MOV" {
            let videoData = filterHorseArrDetails?.data?[indexPath.row].thumbnail
            let imgArr : [String] = videoData?.components(separatedBy: ",") ?? []
            cell.horseImageView.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        
        cell.lblHorsebreed.text = filterHorseArrDetails?.data?[indexPath.row].title
        let price =  "$" + (filterHorseArrDetails?.data?[indexPath.row].price?.formatUsingAbbrevation() ?? "")
        cell.lblPrice.text = price
        let counedTime = filterHorseArrDetails?.data?[indexPath.row].posttime
        if let convertTime = counedTime{
            cell.lblTime.text =  convertTimeInDaysAgo(interval: Int(convertTime))
        }
        //Check
        cell.premiumView.isHidden = !(filterHorseArrDetails?.data?[indexPath.row].premium == 1)
        let shares = filterHorseArrDetails?.data?[indexPath.row].shares?.formatUsingAbbrevation()
        cell.lblShares.text = (shares ?? "0") + " shares"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.horseDetailsCollectionView.bounds.width / 2 - 4.5 , height : self.horseDetailsCollectionView.bounds.width / 2  )
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
        vc.mode = .horse
        vc.currentItemID = filterHorseArrDetails?.data?[indexPath.row].id ?? 0
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- API calling.
extension HorsesListViewController{
    func filterHorseCallAPI(discipline: [String],gender: [String],horse_breed:[String],minPrice: Int, maxPrice: Int,color: [String],minAge: Int, maxAge: Int,minHeight: String, maxHeight: String, location: String, keyword: String){
        filterHorseViewModel.data.removeAll()
        showActivityIndicator(uiView: self.view)
        if keyword != ""{
            filterHorseViewModel.data["keywords"] = keyword
        }
        
        filterHorseViewModel.data["discipline"] = discipline
        filterHorseViewModel.data["gender"] = gender
        
        filterHorseViewModel.data["color"] = color
        if location != ""{
            filterHorseViewModel.data["location"] = location
        }
        if horse_breed.count != 0{
            filterHorseViewModel.data["horse_breed"] = horse_breed
        }
        if minPrice != 0 && maxPrice != 0{
            filterHorseViewModel.data["minPrice"] = minPrice
            filterHorseViewModel.data["maxPrice"] = maxPrice
        }
        if minAge != 0 && maxAge != 0{
            filterHorseViewModel.data["minAge"] = minAge
            filterHorseViewModel.data["maxAge"] = maxAge
        }
        if minHeight != "" && maxHeight != ""{
            filterHorseViewModel.data["minHeight"] = minHeight
            filterHorseViewModel.data["maxHeight"] = maxHeight
        }
//        if minLTE != 0 && maxLTE != 0{
//            filterHorseViewModel.data["minHeight"] = minHeight
//            filterHorseViewModel.data["maxHeight"] = maxHeight
//        }
        
        filterHorseViewModel.getFilterHoses{ (isFinished, message) in
            
            if isFinished
            {
                self.filterHorseArrDetails = self.filterHorseViewModel.horseFilterData
                if self.filterHorseArrDetails?.data?.count == 0{
                    self.horseDetailsCollectionView.setEmptyMessage("There is no matched list available")
                }else{
                    self.horseDetailsCollectionView.setEmptyMessage("")
                }
                self.horseDetailsCollectionView.reloadData()
                hideActivityIndicator(uiView: self.view)
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension HorsesListViewController: ReloadCollectionViewForShareCountDelegate {
    func shareCount() {
        self.filterHorseCallAPI(discipline: [], gender: [], horse_breed: [], minPrice: 0, maxPrice: 0, color: [], minAge: 0, maxAge: 0, minHeight: "", maxHeight: "", location: "", keyword: "")
    }
}
