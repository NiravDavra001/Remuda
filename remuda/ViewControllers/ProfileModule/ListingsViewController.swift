//
//  ListingsViewController.swift
//  remuda
//
//  Created by Macmini on 14/04/21.
//

import UIKit

class ListingsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var getSavedListingViewModel = SavedListingsViewModel()
    var savedListingArrayDetails : SavedListingsModel?
    var listingSaveViewModel = SaveHorseTackEquipmentsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
        self.getSavedListingsAPICall()
    }
    private func setUpCollectionview() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: CollectionCellIdentifiers.ListingViewCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.ListingViewCVCell.rawValue)
    }
}

//MARK:- API calling.
extension ListingsViewController {
    func getSavedListingsAPICall(){
        showActivityIndicator(uiView: self.view)
        getSavedListingViewModel.getSavedListAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.savedListingArrayDetails  = self.getSavedListingViewModel.getSavedListingData
                self.collectionView.reloadData()
                if self.savedListingArrayDetails?.data?.count == 0{
                    self.collectionView.setEmptyMessage("There is no saved listing available to add save from the marketplace")
                }else{
                    self.collectionView.setEmptyMessage("")
                }
                print("success")
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
                self.getSavedListingsAPICall()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

//MARK:- UICollevtionView datasource and delegate methods.
extension ListingsViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedListingArrayDetails?.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.ListingViewCVCell.rawValue, for: indexPath) as! ListingViewCollectionViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        
        let type = savedListingArrayDetails?.data?[indexPath.row].media
        let imgArr : [String] = type?.components(separatedBy: ",") ?? []
        let data = imgArr.first?.components(separatedBy: ".")
        if data?.last == "jpeg" {
            cell.imgDetails.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        } else if data?.last == "MOV" {
            let videoData = savedListingArrayDetails?.data?[indexPath.row].thumbnail
            let imgArr : [String] = videoData?.components(separatedBy: ",") ?? []
            cell.imgDetails.sd_setImage(with: URL(string: imgArr.first ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        
        cell.lblHourseName.text = savedListingArrayDetails?.data?[indexPath.row].title
        let price =  "$" + (savedListingArrayDetails?.data?[indexPath.row].price?.formatUsingAbbrevation() ?? "")
        cell.lblHoursePriice.text = price
        let counedTime = savedListingArrayDetails?.data?[indexPath.row].posttime
        if let convertTime = counedTime{
            cell.lblPostUploadedTime.text =  convertTimeInDaysAgo(interval: Int(convertTime))
        }
        //TODO: check for racing view
        cell.racingView.isHidden = !(savedListingArrayDetails?.data?[indexPath.row].types == 1)
        let categoryDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: HorseCategoryModel.self, key: .storeAllHorseCategory)
        
        if cell.racingView.isHidden == false {
            _ = categoryDetails?.data?.discipline.map({ (arr) in
                arr.map { (discipline) in
                    if discipline.id == savedListingArrayDetails?.data?[indexPath.row].discipline{
                        cell.lblTopRacing.text = (discipline.value)?.uppercased()
                    }
                }
            })
        }
        let shares = savedListingArrayDetails?.data?[indexPath.row].shares?.formatUsingAbbrevation()
        cell.lblPostShare.text = (shares ?? "0") + " shares"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = self.loadViewController(Storyboard: .MarketPlace, ViewController: .HorseDetailsVC) as! HorseDetailsViewController
        
        switch self.savedListingArrayDetails?.data?[indexPath.row].types {
        case 1:
            if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                vc.mode = .horse
                vc.currentItemID = id
            }
        case 2:
            if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                vc.mode = .tack
                vc.currentItemID = id
            }
        case 3:
            if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                vc.mode = .equipmment
                vc.currentItemID = id
            }
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    //MARK: collectionview height width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / 2 - 6 , height : self.collectionView.bounds.width / 2  )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }

}

extension ListingsViewController: UnSaveListingDelegate {
    func didPressUnsave(indexPath: IndexPath) {
        if savedListingArrayDetails?.data?[indexPath.row].isSave == 1{
            switch self.savedListingArrayDetails?.data?[indexPath.row].types {
            case 1:
                if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                    self.listingSaveViewModel.dict["horseunsave"] = "\(id)"
                }
            case 2:
                if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                    self.listingSaveViewModel.dict["tackunsave"] = "\(id)"
                }
            case 3:
                if let id = savedListingArrayDetails?.data?[indexPath.row].itemId{
                    self.listingSaveViewModel.dict["equipunsave"] = "\(id)"
                }
            default:
                break
            }
            self.listingSaveCallAPI()
            self.listingSaveViewModel.dict.removeAll()
        }
    }
}
