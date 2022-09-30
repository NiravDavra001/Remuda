//
//  SearchNewsFeedViewController.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//
import UIKit

class SearchNewsFeedViewController: UIViewController {
    
    @IBOutlet var lblSearchResult: UILabel!
    @IBOutlet var tblSearchData: UITableView!
    @IBOutlet var searchBarNewsFeed: UISearchBar!
    var searchedArray = [String]()
    var searching = false
    
    
    var viewModel = HomeViewModel()
    var arrDetails : PostsModel?
    var saveLikeModel = SaveLikeViewModel()
    var initialLikeArray = [String]()
    var initialDisLikeArray = [String]()
    var initialSaveArray = [String]()
    var initialUnsavedArray = [String]()
    var like = [String]()
    var unlike = [String]()
    var save = [String]()
    var unsave = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will diaappear called")
        
        if save.count != 0{
            for initialSaveItem in 0..<initialSaveArray.count{
                for saveItem in 0..<save.count{
                    if initialSaveArray[initialSaveItem] == save[saveItem]{
                        save.remove(at: saveItem)
                        break
                    }
                }
            }
            saveLikeModel.dict["save"] = save.joined(separator: ",")
        }
        if unsave.count != 0{
            for initialUnsaveItem in 0..<initialUnsavedArray.count{
                for unsaveItem in 0..<unsave.count{
                    if unsave[unsaveItem] == initialUnsavedArray[initialUnsaveItem] {
                        unsave.remove(at: unsaveItem)
                        break
                    }
                }
            }
            
            saveLikeModel.dict["unsave"] = unsave.joined(separator: ",")
        }
        
        if like.count != 0{
            for initialLikeItem in 0..<initialLikeArray.count{
                for likeItem in 0..<like.count{
                    if initialLikeArray[initialLikeItem] == like[likeItem]{
                        like.remove(at: likeItem)
                        break
                    }
                }
            }
            saveLikeModel.dict["like"] = like.joined(separator: ",")
        }
        if unlike.count != 0{
            for initialDisLikeItem in 0..<initialDisLikeArray.count{
                for disLikeItem in 0..<unlike.count{
                    if unlike[disLikeItem] == initialDisLikeArray[initialDisLikeItem] {
                        unlike.remove(at: disLikeItem)
                        break
                    }
                }
            }
            
            saveLikeModel.dict["unlike"] = unlike.joined(separator: ",")
        }
        
        likeCallAPI()
        initialLikeArray.removeAll()
        initialDisLikeArray.removeAll()
        like.removeAll()
        unlike.removeAll()
        
        initialSaveArray.removeAll()
        initialUnsavedArray.removeAll()
        save.removeAll()
        unsave.removeAll()
        saveLikeModel.dict.removeAll()
        
    }
    func setUpUI(){ 
        self.title = ViewControllerTitle.searchNewsFeed.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        tblSearchData.dataSource  = self
        tblSearchData.delegate = self
        tblSearchData.separatorStyle = .none
        tblSearchData.register(UINib(nibName: TableCellIdentifiers.HomePostsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue)
        
        lblSearchResult.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        searchBarSetUp()
    }
    func searchBarSetUp(){
        searchBarNewsFeed.delegate = self
        searchBarNewsFeed.searchBarStyle = .minimal
        searchBarNewsFeed.searchTextField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        searchBarNewsFeed.searchTextField.leftView?.tintColor = .black
        searchBarNewsFeed.tintColor = .black
        searchBarNewsFeed.placeholder = "Search"
        searchBarNewsFeed.barTintColor = .selectPhoto_background
    }
    func homeFeedCallAPI(message: String){
        viewModel.data.removeAll()
        viewModel.data["message"] = message
        let msg = message
        showActivityIndicator(uiView: self.view)
        viewModel.getAppHomeFeedPosts { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.arrDetails = self.viewModel.homeFeedPost
                if msg == ""{
                    self.arrDetails?.data?.removeAll()
                    self.lblSearchResult.text = "\(self.arrDetails?.data?.count ?? 0) results"
                }else{
                    self.lblSearchResult.text = "\(self.arrDetails?.data?.count ?? 0) results for" + "\"\(msg)\""
                }
                
                _ = self.arrDetails?.data?.map({ (postdata) in
                    if postdata.isLike == 1{
                        self.initialLikeArray.append(String(postdata.id ?? 0))
                    }else{
                        self.initialDisLikeArray.append(String(postdata.id ?? 0))
                    }
                    
                    if postdata.isSave == 1{
                        self.initialSaveArray.append(String(postdata.id ?? 0))
                    }else{
                        self.initialUnsavedArray.append(String(postdata.id ?? 0))
                    }
                })
                
                if self.arrDetails?.data?.count == 0{
                    self.tblSearchData.setEmptyMessage("There is no data match with the searched text")
                }else{
                    self.tblSearchData.setEmptyMessage("")
                }
                self.tblSearchData.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    func commentCallAPI(){
        showActivityIndicator(uiView: self.view)
        saveLikeModel.saveLikeAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                print("saved")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    func likeCallAPI(){
        showActivityIndicator(uiView: self.view)
        
        saveLikeModel.saveLikeAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension  SearchNewsFeedViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return arrDetails?.data?.count ?? 0
        }else{
            return arrDetails?.data?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homePostsTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue) as! HomePostsTableViewCell
        homePostsTVCell.selectionStyle = .none
        if searching{
            let imgUrl = arrDetails?.data?[indexPath.row].image
            homePostsTVCell.postedUserimage.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
            let fname = arrDetails?.data?[indexPath.row].firstName
            let lname = arrDetails?.data?[indexPath.row].lastName
            homePostsTVCell.lblUserName.text = "\(fname ?? "") \(lname ?? "")"
            
            var postTime = arrDetails?.data?[indexPath.row].createdAt ?? ""
            postTime.removeLast(5)
            homePostsTVCell.lblTime.text = postTime.timeInterval(timeAgo: postTime)
            
            homePostsTVCell.lblPostTextDetail.text = arrDetails?.data?[indexPath.row].message
            if arrDetails?.data?[indexPath.row].media?.isEmpty ?? true{
                homePostsTVCell.viewForImageView.isHidden = true
            }else{
                homePostsTVCell.viewForImageView.isHidden = false
                let imgUrl1 = arrDetails?.data?[indexPath.row].media
                let imgArr : [String] = imgUrl1?.components(separatedBy: ",") ?? []
                homePostsTVCell.imageURLData = imgArr
                let video = arrDetails?.data?[indexPath.row].thumbnail
                let videoThumbnialArray : [String] = video?.components(separatedBy: ",") ?? []
                homePostsTVCell.videoURLData = videoThumbnialArray
            }
            
            if arrDetails?.data?[indexPath.row].isLike == 1{
                homePostsTVCell.lblLikeCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                homePostsTVCell.lblLikeCount.textColor = .postLike_red_color
                homePostsTVCell.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
                homePostsTVCell.btnLike.setImage(UIImage(named: "like"), for: .normal)
            }else{
                homePostsTVCell.lblLikeCount.setSemiBold13SizeFont()
                homePostsTVCell.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
                homePostsTVCell.btnLike.setImage(UIImage(named: "Unlike"), for: .normal)
            }
            if arrDetails?.data?[indexPath.row].isSave == 1{
                homePostsTVCell.lblSaved.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                homePostsTVCell.lblSaved.textColor = .postLike_red_color
                homePostsTVCell.lblSaved.text = "Saved"
                homePostsTVCell.btnSaved.tintColor = .postLike_red_color
                homePostsTVCell.btnSaved.setImage(UIImage(named: "saved"), for: .normal)
            }else{
                homePostsTVCell.lblSaved.setSemiBold13SizeFont()
                homePostsTVCell.lblSaved.text = "Save"
                homePostsTVCell.btnSaved.tintColor = .label_bookmarks_postGrey_color
                homePostsTVCell.btnSaved.setImage(UIImage(named: "Unsaved"), for: .normal)
            }
            homePostsTVCell.delegate = self
            homePostsTVCell.lblCommentCount.text = String(arrDetails?.data?[indexPath.row].TotalComment ?? 0)
            homePostsTVCell.index = indexPath.row
            homePostsTVCell.indexPath = indexPath
            return homePostsTVCell
            
        }else{
            
            let imgUrl = arrDetails?.data?[indexPath.row].image
            homePostsTVCell.postedUserimage.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
            let fname = arrDetails?.data?[indexPath.row].firstName
            let lname = arrDetails?.data?[indexPath.row].lastName
            homePostsTVCell.lblUserName.text = "\(fname ?? "") \(lname ?? "")"
            
            var postTime = arrDetails?.data?[indexPath.row].createdAt ?? ""
            postTime.removeLast(5)
            homePostsTVCell.lblTime.text = postTime.timeInterval(timeAgo: postTime)
            
            homePostsTVCell.lblPostTextDetail.text = arrDetails?.data?[indexPath.row].message
            homePostsTVCell.viewForImageView.isHidden = false
            let imgUrl1 = arrDetails?.data?[indexPath.row].media
            homePostsTVCell.contentImage.sd_setImage(with: URL(string: imgUrl1 ?? ""), completed: nil)
            
            if arrDetails?.data?[indexPath.row].isLike == 1{
                homePostsTVCell.lblLikeCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                homePostsTVCell.lblLikeCount.textColor = .postLike_red_color
                homePostsTVCell.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
                homePostsTVCell.btnLike.setImage(UIImage(named: "like"), for: .normal)
            }else{
                homePostsTVCell.lblLikeCount.setSemiBold13SizeFont()
                homePostsTVCell.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
                homePostsTVCell.btnLike.setImage(UIImage(named: "Unlike"), for: .normal)
            }
            if arrDetails?.data?[indexPath.row].isSave == 1{
                homePostsTVCell.lblSaved.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                homePostsTVCell.lblSaved.textColor = .postLike_red_color
                homePostsTVCell.lblSaved.text = "Saved"
                homePostsTVCell.btnSaved.tintColor = .postLike_red_color
                homePostsTVCell.btnSaved.setImage(UIImage(named: "saved"), for: .normal)
            }else{
                homePostsTVCell.lblSaved.setSemiBold13SizeFont()
                homePostsTVCell.lblSaved.text = "Save"
                homePostsTVCell.btnSaved.tintColor = .label_bookmarks_postGrey_color
                homePostsTVCell.btnSaved.setImage(UIImage(named: "Unsaved"), for: .normal)
            }
            homePostsTVCell.delegate = self
            homePostsTVCell.lblCommentCount.text = String(arrDetails?.data?[indexPath.row].TotalComment ?? 0)
            homePostsTVCell.index = indexPath.row
            homePostsTVCell.indexPath = indexPath
            return homePostsTVCell
            
            
        }
    }
}
extension SearchNewsFeedViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.homeFeedCallAPI(message: searchText)
        searching = true
        tblSearchData.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tblSearchData.reloadData()
    }
}
extension SearchNewsFeedViewController: UpdateTableviewDataDelegate{
    func updateTableview(index: Int) {
        self.tblSearchData.reloadData()
    }
    func didPressSavedButton(indexPath: IndexPath) {
        /* post_id
         type : 1=like, 2=save
         is_delete :0,1 (0 pass karso to insert thase and 1 pass karso to a record remove thase) */
        
        if arrDetails?.data?[indexPath.row].isSave == 1{
            for i in 0..<save.count{
                if Int(save[i]) == arrDetails?.data?[indexPath.row].id{
                    save.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isSave = 0
            unsave.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblSearchData.reloadRows(at: [indexPath], with: .none)
        }else{
            for i in 0..<unsave.count{
                if Int(unsave[i]) == arrDetails?.data?[indexPath.row].id{
                    unsave.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isSave = 1
            save.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblSearchData.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    func didPressCommentButton(tag: IndexPath) {
        let vc = loadViewController(Storyboard: .Home, ViewController: .SelectedHomePostVC) as! SelectedHomePostViewController
        vc.arrDetails = arrDetails?.data?[tag.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func btnLike(indexPath: IndexPath) {
        
        if arrDetails?.data?[indexPath.row].isLike == 1{
            for i in 0..<like.count{
                if Int(like[i]) == arrDetails?.data?[indexPath.row].id{
                    like.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isLike = 0
            arrDetails?.data?[indexPath.row].TotalLike! -= 1
            unlike.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblSearchData.reloadRows(at: [indexPath], with: .none)
        }else{
            for i in 0..<unlike.count{
                if Int(unlike[i]) == arrDetails?.data?[indexPath.row].id{
                    unlike.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isLike = 1
            arrDetails?.data?[indexPath.row].TotalLike! += 1
            like.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblSearchData.reloadRows(at: [indexPath], with: .none)
        }
    }
    func btnShareAction(indexPath: IndexPath) {
    }
}
