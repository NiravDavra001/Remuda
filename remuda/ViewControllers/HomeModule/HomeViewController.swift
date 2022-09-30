//
//  HomeViewController.swift
//  remuda
//
//  Created by mac on 09/04/21.
//
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices


class HomeViewController: UIViewController {
    
    @IBOutlet var btnRightNewPost: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnFilter: UIButton!
    var noOfLinefForDescriptionLabel = 3
    @IBOutlet var lblNavigationTitle: UILabel!
    @IBOutlet var tblHomePost: UITableView!
    var viewModel = HomeViewModel()
    var arrDetails : PostsModel?
    var isFirstTime = true
    var saveLikeModel = SaveLikeViewModel()
    var initialLikeArray = [String]()
    var initialDisLikeArray = [String]()
    var initialSaveArray = [String]()
    var initialUnsavedArray = [String]()
    var like = [String]()
    var unlike = [String]()
    var save = [String]()
    var unsave = [String]()
    var profileDataViewModel = ProfileDetailViewModel()
    var profileDataArrDetails : ProfileDetailModel?
    let allCategoryViewModel = HorseCategoryViewModel()
    var arrCategory : HorseCategoryModel?
    var city: String?
    let refreshControl = UIRefreshControl()
    var videoURLData: [String]?
    var demoData : [String?]?
    override func viewDidLoad() {
        self.homeFeedCallAPI(city: "") {
            self.getProfileCallAPI()
            self.getAllHorseCategoryCallAPI()
        }
        self.setUpUI()
        self.setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("will will called")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if isFirstTime {
            isFirstTime = false
        }
        else{
            if city?.isEmpty == true || city == ""{
                self.homeFeedCallAPI(city: "") {
                    print("homeFeedCallAPI")
                }
            }
        }
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnSearch.setRoundedView()
        self.btnFilter.setRoundedView()
    }
    private func Add_All(){
        let allBreed = Breed(categoryId: 1, id: nil, value: "All Breeds", isSelected: false)
        let allDiscipline = Discipline(categoryId: 2, id: nil, value: "All Disciplines", isSelected: false)
        let allColor = Color(categoryId: 3, id: nil, value: "Any Color", isSelected: false)
        let allGender = Gender(categoryId: 4, id: nil, value: "All Genders", isSelected: false)
        
        let allSaddle = Saddle(categoryId: 5, id: 1001, value: "All", isSelected: false, isSaddle: false)
        let saddleData = Saddle(categoryId: 5, id: 1002, value: "Saddles", isSelected: false, isSaddle: false)
        let allCondition = Condition(categoryId: 6, id: nil, value: "All", isSelected: false)
        
        let allTackCondition = TackCondition(categoryId: 8, id: nil, value: "All", isSelected: false)
        
        arrCategory?.data?.breed?.insert(allBreed, at: 0)
        arrCategory?.data?.discipline?.insert(allDiscipline, at: 0)
        arrCategory?.data?.color?.insert(allColor, at: 0)
        arrCategory?.data?.gender?.insert(allGender, at: 0)
        
        arrCategory?.data?.saddle?.insert(allSaddle, at: 0)
        arrCategory?.data?.saddle?.insert(saddleData, at: 1)
        arrCategory?.data?.condition?.insert(allCondition, at: 0)
        arrCategory?.data?.tackCondition?.insert(allTackCondition, at: 0)
    }
    private func setUpUI(){
        self.lblNavigationTitle.text = ViewControllerTitle.home.rawValue
        self.lblNavigationTitle.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_20))
        self.btnRightNewPost.setTitle("New Post", for: .normal)
        self.btnRightNewPost.setTitleColor(.white, for: .normal)
        self.btnRightNewPost.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.btnRightNewPost.semanticContentAttribute = .forceRightToLeft
            self.btnRightNewPost.setRoundedView()
            self.btnSearch.setBorder(1, UIColor.button_border_color)
            self.btnFilter.setBorder(1, UIColor.button_border_color)
        }
    }
    
    private func setUpTableView() {
        self.tblHomePost.dataSource = self
        self.tblHomePost.delegate = self
        self.tblHomePost.separatorStyle = .none
        self.tblHomePost.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        self.tblHomePost.register(UINib(nibName: TableCellIdentifiers.HomePostsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue)
    }
    @objc func refreshTableViewData() {
        self.refreshControl.endRefreshing()
        self.homeFeedCallAPI(city: "") {
        }
    }
    
    @IBAction func btnRightNewPost(_ sender: UIButton) {
        let vc = loadViewController(Storyboard: .Home, ViewController: .CreateNewPostVC) as! CreateNewPostViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        self.pushViewController( controllerID : .SearchNewsFeedVC,storyBoardID : .Home)
    }
    @IBAction func btnFilter(_ sender: Any) {
        let vc = loadViewController(Storyboard: .Home, ViewController: .FilterByLocationVC) as! FilterByLocationViewController
        vc.delegate = self
        print("filter tapped")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetails?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homePostsTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue) as? HomePostsTableViewCell
        homePostsTVCell?.selectionStyle = .none
        let imgUrl = arrDetails?.data?[indexPath.row].image
        homePostsTVCell?.postedUserimage.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        let fname = arrDetails?.data?[indexPath.row].firstName
        let lname = arrDetails?.data?[indexPath.row].lastName
        homePostsTVCell?.lblUserName.text = "\(fname ?? "") \(lname ?? "")"
        var postTime = arrDetails?.data?[indexPath.row].createdAt ?? ""
        postTime.removeLast(5)
        homePostsTVCell?.lblTime.text = postTime.timeInterval(timeAgo: postTime)
        homePostsTVCell?.message = arrDetails?.data?[indexPath.row].message
        homePostsTVCell?.lblPostTextDetail.numberOfLines = noOfLinefForDescriptionLabel
        if arrDetails?.data?[indexPath.row].media?.isEmpty ?? true{
            homePostsTVCell?.viewForImageView.isHidden = true
        }else{
            homePostsTVCell?.viewForImageView.isHidden = false
            let imgUrl1 = arrDetails?.data?[indexPath.row].media
            let imgArr : [String] = imgUrl1?.components(separatedBy: ",") ?? []
            homePostsTVCell?.imageURLData = imgArr
            if let video = arrDetails?.data?[indexPath.row].thumbnail{
                let videoThumbnialArray : [String] = video.components(separatedBy: ",")
                homePostsTVCell?.videoURLData = videoThumbnialArray
                videoURLData = videoThumbnialArray
            }
        }
        if arrDetails?.data?[indexPath.row].isLike == 1{
            homePostsTVCell?.lblLikeCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
            homePostsTVCell?.lblLikeCount.textColor = .postLike_red_color
            homePostsTVCell?.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
            homePostsTVCell?.btnLike.setImage(UIImage(named: "like"), for: .normal)
        }else{
            homePostsTVCell?.lblLikeCount.setSemiBold13SizeFont()
            homePostsTVCell?.lblLikeCount.text = "\(arrDetails?.data?[indexPath.row].TotalLike ?? 0)"
            homePostsTVCell?.btnLike.setImage(UIImage(named: "Unlike"), for: .normal)
        }
        if arrDetails?.data?[indexPath.row].isSave == 1{
            homePostsTVCell?.lblSaved.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
            homePostsTVCell?.lblSaved.textColor = .postLike_red_color
            homePostsTVCell?.lblSaved.text = "Saved"
            homePostsTVCell?.btnSaved.tintColor = .postLike_red_color
            homePostsTVCell?.btnSaved.setImage(UIImage(named: "saved"), for: .normal)
        }else{
            homePostsTVCell?.lblSaved.setSemiBold13SizeFont()
            homePostsTVCell?.lblSaved.text = "Save"
            homePostsTVCell?.btnSaved.tintColor = .label_bookmarks_postGrey_color
            homePostsTVCell?.btnSaved.setImage(UIImage(named: "Unsaved"), for: .normal)
        }
        homePostsTVCell?.lblCommentCount.text = String(arrDetails?.data?[indexPath.row].TotalComment ?? 0)
        homePostsTVCell?.delegate = self
        homePostsTVCell?.index = indexPath.row
        homePostsTVCell?.indexPath = indexPath
        homePostsTVCell?.playVideoDelegate = self
       homePostsTVCell?.photoGalleryDelegate = self
        return homePostsTVCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let homePostsTVCell = tableView.cellForRow(at: indexPath) as? HomePostsTableViewCell {
            homePostsTVCell.index = indexPath.row
        }
    }
}
//MARK:- Filter by location delegate method.
extension HomeViewController: FilterByLocationDelegate{
    func filterByLocation(city: String) {
        self.city = city
        self.homeFeedCallAPI(city: city) {
            print("homeFeedCallAPI")
        }
    }
}
//MARK:- Play video using AVPlayer.
extension HomeViewController: HomeFeedDelegate{
    func playSelectedVideo(url: String) {
        playVideo(videoUrl: url)
    }
    func btnseeMoreAction(indexPath: IndexPath) {
        if noOfLinefForDescriptionLabel == 0{
            noOfLinefForDescriptionLabel = 3
        }else{
            noOfLinefForDescriptionLabel = 0
        }
        self.tblHomePost.reloadRows(at: [indexPath], with: .none)
    }
}
//MARK:- API calling.
extension HomeViewController {
    private func homeFeedCallAPI(city: String, completion: @escaping () -> Void){
        viewModel.data.removeAll()
        viewModel.data["city"] = city
        showActivityIndicator(uiView: self.view)
        viewModel.getAppHomeFeedPosts { (isFinished, message) in
            
            if isFinished
            {
                self.arrDetails = self.viewModel.homeFeedPost
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
                    self.tblHomePost.setEmptyMessage("There is no post available to add post click on new post")
                }else{
                    self.tblHomePost.setEmptyMessage("")
                }
                self.tblHomePost.reloadData()
                hideActivityIndicator(uiView: self.view)
                self.city = ""
                print("success")
                completion()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    private func getProfileCallAPI(){
        //        showActivityIndicator(uiView: self.view)
        profileDataViewModel.getUserProfileAPI{ (isFinished, message) in
            //            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.profileDataArrDetails  = self.profileDataViewModel.getUserProfileList
                UserDefaultManager.share.storeModelToUserDefault(userData: self.profileDataArrDetails, key: .storeProfile)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    private func getAllHorseCategoryCallAPI(){
        //        showActivityIndicator(uiView: self.view)
        allCategoryViewModel.getAllCategoryApi { (isFinished, message) in
            //            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.arrCategory  = self.allCategoryViewModel.getAllCategory
                self.Add_All()
                UserDefaultManager.share.storeModelToUserDefault(userData: self.arrCategory, key: .storeAllHorseCategory)
            }else{
                self.showAlert(message: message)
            }
        }
    }
    private func commentCallAPI(){
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
    private func likeCallAPI(){
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

extension HomeViewController: UpdateTableviewDataDelegate{
    func updateTableview(index: Int) {
        self.tblHomePost.reloadData()
    }
    func didPressSavedButton(indexPath: IndexPath) {
        /* MARK:- type : 1 = like, 2 = save is_delete :0,1 (to insert pass 0 and to remove pass 1) */
        
        if arrDetails?.data?[indexPath.row].isSave == 1{
            for i in 0..<save.count{
                if Int(save[i]) == arrDetails?.data?[indexPath.row].id{
                    save.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isSave = 0
            unsave.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblHomePost.reloadRows(at: [indexPath], with: .none)
        }else{
            for i in 0..<unsave.count{
                if Int(unsave[i]) == arrDetails?.data?[indexPath.row].id{
                    unsave.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isSave = 1
            save.append(String(arrDetails?.data?[indexPath.row].id ?? 0))
            self.tblHomePost.reloadRows(at: [indexPath], with: .none)
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
            self.tblHomePost.beginUpdates()
            self.tblHomePost.reloadRows(at: [indexPath], with: .none)
            self.tblHomePost.endUpdates()
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
            self.tblHomePost.beginUpdates()
            self.tblHomePost.reloadRows(at: [indexPath], with: .none)
            self.tblHomePost.endUpdates()
        }
    }
    func btnShareAction(indexPath: IndexPath) {
        showShareActivity(url: "remuda://remuda.com/home-posts/\(arrDetails?.data?[indexPath.row].id ?? 0)")
    }
}
extension HomeViewController : PhotoGalleryDelegate{
    func photoGalleryAction(indexPath: IndexPath?, arrGalleryItem: [String]?, videoData: [String]?) {
        let PostGalleryVC = storyboard?.instantiateViewController(identifier: "PostGalleryViewController") as! PostGalleryViewController
        if let index = indexPath{
            PostGalleryVC.index = index
        }
        PostGalleryVC.modalPresentationStyle = .fullScreen
        PostGalleryVC.modalTransitionStyle = .crossDissolve
        PostGalleryVC.imageURLData = arrGalleryItem
        PostGalleryVC.videoURLData = videoData
       // PostGalleryVC.videoURLData = videoURLData
        present(PostGalleryVC, animated: true, completion: nil)
    }
    
   
}
