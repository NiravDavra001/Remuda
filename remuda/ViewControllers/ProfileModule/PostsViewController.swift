//
//  PostsViewController.swift
//  remuda
//
//  Created by Macmini on 14/04/21.
//

struct UserPostModel {
    var profilePic: UIImage?
    var userName: String?
    var totalUploadTime: String?
    var isDescription: String?
    var isImageuploaded: UIImage?
    var isLiked : Bool?
    var isLikeCount: Int?
    var isCommentCount: Int?
    var isSaved: Bool? = true
    var comment: [CommentModel]?
}
struct CommentModel {
    var comment: String?
    var reply: [String]?
}

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet var tblPosts: UITableView!
    var viewModel = SavedPostViewModel()
    var arrDetails : PostsModel?
    var saveLikeModel = SaveLikeViewModel()
    var isCalled = true
    var noOfLinefForDescriptionLabel = 3
    var like = [String]()
    var unlike = [String]()
    var initialLikeArray = [String]()
    var initialDisLikeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpTableview()
    }
    override func viewDidLayoutSubviews() {
        self.tblPosts.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
        
        if self.isCalled{
            self.isCalled = false
        }else{
            self.getSavedPostAPICall()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("will diaappear called")
        
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
        
        likeSaveCallAPI()
        initialLikeArray.removeAll()
        initialDisLikeArray.removeAll()
        like.removeAll()
        unlike.removeAll()
        saveLikeModel.dict.removeAll()
    }
    
    private func setUpUI(){
    }
    private func setUpTableview() {
        tblPosts.dataSource = self
        tblPosts.delegate = self
        tblPosts.separatorStyle = .none
        tblPosts.register(UINib(nibName: TableCellIdentifiers.HomePostsTVCell.rawValue, bundle: nil),     forCellReuseIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue)
    }
    
}

//MARK:- Tableview datasourse and delegate methods.
extension PostsViewController: UITableViewDataSource,UITableViewDelegate{
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
            let video = arrDetails?.data?[indexPath.row].thumbnail
            let videoThumbnialArray : [String] = video?.components(separatedBy: ",") ?? []
            homePostsTVCell?.videoURLData = videoThumbnialArray
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
        homePostsTVCell?.delegate = self
        homePostsTVCell?.lblCommentCount.text = String(arrDetails?.data?[indexPath.row].TotalComment ?? 0)
        homePostsTVCell?.index = indexPath.row
        homePostsTVCell?.indexPath = indexPath
        homePostsTVCell?.playVideoDelegate = self
        return homePostsTVCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postsTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PostsTVCell.rawValue) as? PostsTableViewCell
        postsTableViewCell?.index = indexPath.row
    }
}
//MARK:- Play video using AVPlayer.
extension PostsViewController: HomeFeedDelegate{
    func playSelectedVideo(url: String) {
        playVideo(videoUrl: url)
    }
    func btnseeMoreAction(indexPath: IndexPath) {
        if noOfLinefForDescriptionLabel == 0{
            noOfLinefForDescriptionLabel = 3
        }else{
            noOfLinefForDescriptionLabel = 0
        }
        self.tblPosts.reloadRows(at: [indexPath], with: .none)
    }
}
//MARK:- Tableview cell button actions.
extension PostsViewController: UpdateTableviewDataDelegate{
    func updateTableview(index: Int) {
        self.tblPosts.reloadData()
    }
    func didPressSavedButton(indexPath: IndexPath) {
        if arrDetails?.data?[indexPath.row].isSave == 1{
            var arr = [String]()
            arr.append(String(arrDetails?.data?[indexPath.row].post_id ?? 0))
            self.saveLikeModel.dict["unsave"] = arr.joined(separator: ",")
            self.likeSaveCallAPI()
        }
    }
    func didPressCommentButton(tag: IndexPath) {
        let vc = loadViewController(Storyboard: .Profile, ViewController: .SelectedPostVC) as! SelectedPostViewController
        vc.arrDetails = arrDetails?.data?[tag.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func btnLike(indexPath: IndexPath) {
        if arrDetails?.data?[indexPath.row].isLike == 1{
            for i in 0..<like.count{
                if Int(like[i]) == arrDetails?.data?[indexPath.row].post_id{
                    like.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isLike = 0
            arrDetails?.data?[indexPath.row].TotalLike! -= 1
            unlike.append(String(arrDetails?.data?[indexPath.row].post_id ?? 0))
            self.tblPosts.beginUpdates()
            self.tblPosts.reloadRows(at: [indexPath], with: .none)
            self.tblPosts.endUpdates()
        }else{
            for i in 0..<unlike.count{
                if Int(unlike[i]) == arrDetails?.data?[indexPath.row].post_id{
                    unlike.remove(at: i)
                    break
                }
            }
            arrDetails?.data?[indexPath.row].isLike = 1
            arrDetails?.data?[indexPath.row].TotalLike! += 1
            like.append(String(arrDetails?.data?[indexPath.row].post_id ?? 0))
            self.tblPosts.beginUpdates()
            self.tblPosts.reloadRows(at: [indexPath], with: .none)
            self.tblPosts.endUpdates()
        }
    }
    func btnShareAction(indexPath: IndexPath) {
        showShareActivity(url: "remuda://remuda.com/home-posts/\(arrDetails?.data?[indexPath.row].post_id ?? 0)")
    }
}
//MARK:- API calling.
extension PostsViewController {
    func getSavedPostAPICall(){
        showActivityIndicator(uiView: self.view)
        viewModel.getSavedListAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.arrDetails  = self.viewModel.getSavedPostData
                _ = self.arrDetails?.data?.map({ (postdata) in
                    if postdata.isLike == 1{
                        self.initialLikeArray.append(String(postdata.post_id ?? 0))
                    }else{
                        self.initialDisLikeArray.append(String(postdata.post_id ?? 0))
                    }
                })
                
                if self.arrDetails?.data?.count == 0{
                    self.tblPosts.setEmptyMessage("There is no saved posts available to add save from the home")
                }else{
                    self.tblPosts.setEmptyMessage("")
                }
                self.tblPosts.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    private func likeSaveCallAPI(){
        saveLikeModel.saveLikeAPI{ (isFinished, message) in
            if isFinished {
                self.saveLikeModel.dict.removeAll()
                self.getSavedPostAPICall()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
