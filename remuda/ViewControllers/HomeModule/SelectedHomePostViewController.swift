//
//  SelectedHomePostViewController.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//

struct CommentsModel {
    var comment: [String]?
}
struct AllCommets {
    var id : Int?
    var postId : Int?
    var userId : Int?
    var parentId : Int?
    var firstName : String?
    var lastName : String?
    var image : String?
    var comment : String?
    var createdAt : String?
}
import UIKit
import IQKeyboardManagerSwift
class SelectedHomePostViewController: UIViewController {
    
    @IBOutlet var tblSelectedHomePost: UITableView!
    @IBOutlet var txtHomePostComment: UITextField!
    var arrDetails : PostsData?
    var viewModel = GetCommentViewModel()
    var arrCommentDetails : GetCommentModel?
    var tmpArrCommentDetails = [AllCommets]()
    var commentPostModel = CommentPostViewModel()
    var parentId = 0
    let refreshControl = UIRefreshControl()
    var noOfLinefForDescriptionLabel = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllCommentCallAPI()
        self.setUpUI()
        self.setUpTableView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBarController?.tabBar.isHidden = false
        self.txtHomePostComment.setLeftPaddingPoints(16)
        self.txtHomePostComment.setRightPaddingPoints(16)
        self.txtHomePostComment.setPlaceHolderTextColor(.label_bookmarks_postGrey_color)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.txtHomePostComment.setRoundedView()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
        self.tabBarController?.tabBar.isHidden = false
    }
    private func setTextfieldPlaceholder(plceholderName: String) {
        txtHomePostComment.attributedPlaceholder = NSAttributedString(string: plceholderName, attributes:  [
            .font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14)) ?? 0
        ])
    }
    private func setUpUI(){
        self.title = ViewControllerTitle.home.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        
        self.txtHomePostComment.attributedPlaceholder = NSAttributedString(string: "Leave a comment...", attributes:  [
            .font: UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14)) ?? 0
        ])
        
        self.txtHomePostComment.returnKeyType = .send
        self.txtHomePostComment.inputAccessoryView = UIView()
        self.txtHomePostComment.autocorrectionType = .no
        self.txtHomePostComment.delegate = self
    }
    private func setUpTableView() {
        self.tblSelectedHomePost.dataSource = self
        self.tblSelectedHomePost.delegate = self
        self.tblSelectedHomePost.separatorStyle = .none
        self.tblSelectedHomePost.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        self.tblSelectedHomePost.register(UINib(nibName: TableCellIdentifiers.HomePostsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue)
        self.tblSelectedHomePost.register(UINib(nibName: TableCellIdentifiers.HomePostCommentTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.HomePostCommentTVCell.rawValue)
    }
}


extension SelectedHomePostViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return tmpArrCommentDetails.count
        }else{
            return  0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedHomePostTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HomePostsTVCell.rawValue) as? HomePostsTableViewCell
        let homePostCommentTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.HomePostCommentTVCell.rawValue) as? HomePostCommentTableViewCell
        
        selectedHomePostTVCell?.selectionStyle = .none
        homePostCommentTVCell?.selectionStyle = .none
        if indexPath.section == 0{
            let imgUrl = arrDetails?.image
            selectedHomePostTVCell?.postedUserimage.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
            let fname = arrDetails?.firstName
            let lname = arrDetails?.lastName
            selectedHomePostTVCell?.lblUserName.text = "\(fname ?? "") \(lname ?? "")"
            var postTime = arrDetails?.createdAt
            postTime?.removeLast(5)
            if let countedTime = postTime{
                selectedHomePostTVCell?.lblTime.text = countedTime.timeInterval(timeAgo: countedTime)
            }
            selectedHomePostTVCell?.message = arrDetails?.message
            selectedHomePostTVCell?.lblPostTextDetail.numberOfLines = noOfLinefForDescriptionLabel
            if arrDetails?.media?.isEmpty ?? true{
                selectedHomePostTVCell?.viewForImageView.isHidden = true
            }else{
                selectedHomePostTVCell?.viewForImageView.isHidden = false
            }
            if arrDetails?.media?.isEmpty ?? true{
                selectedHomePostTVCell?.viewForImageView.isHidden = true
            }else{
                selectedHomePostTVCell?.viewForImageView.isHidden = false
                let imgUrl1 = arrDetails?.media
                let imgArr : [String] = imgUrl1?.components(separatedBy: ",") ?? []
                selectedHomePostTVCell?.imageURLData = imgArr
                let video = arrDetails?.thumbnail
                let videoThumbnialArray : [String] = video?.components(separatedBy: ",") ?? []
                selectedHomePostTVCell?.videoURLData = videoThumbnialArray
            }
            if arrDetails?.isLike == 1{
                selectedHomePostTVCell?.lblLikeCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                selectedHomePostTVCell?.lblLikeCount.textColor = .postLike_red_color
                selectedHomePostTVCell?.lblLikeCount.text = "\(arrDetails?.TotalLike ?? 0)"
                selectedHomePostTVCell?.btnLike.setImage(UIImage(named: "like"), for: .normal)
            }else{
                selectedHomePostTVCell?.lblLikeCount.setSemiBold13SizeFont()
                selectedHomePostTVCell?.lblLikeCount.text = "\(arrDetails?.TotalLike ?? 0)"
                selectedHomePostTVCell?.btnLike.setImage(UIImage(named: "Unlike"), for: .normal)
            }
            if arrDetails?.isSave == 1{
                selectedHomePostTVCell?.lblSaved.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_13))
                selectedHomePostTVCell?.lblSaved.textColor = .postLike_red_color
                selectedHomePostTVCell?.lblSaved.text = "Saved"
                selectedHomePostTVCell?.btnSaved.tintColor = .postLike_red_color
                selectedHomePostTVCell?.btnSaved.setImage(UIImage(named: "saved"), for: .normal)
            }else{
                selectedHomePostTVCell?.lblSaved.setSemiBold13SizeFont()
                selectedHomePostTVCell?.lblSaved.text = "Save"
                selectedHomePostTVCell?.btnSaved.tintColor = .label_bookmarks_postGrey_color
                selectedHomePostTVCell?.btnSaved.setImage(UIImage(named: "Unsaved"), for: .normal)
            }
            selectedHomePostTVCell?.lblCommentCount.text = String(arrDetails?.TotalComment ?? 0)
            selectedHomePostTVCell?.playVideoDelegate = self
            selectedHomePostTVCell?.delegate = self
            return selectedHomePostTVCell ?? UITableViewCell()
        }else if indexPath.section == 1{
            homePostCommentTVCell?.indexPath = indexPath
            homePostCommentTVCell?.delegate = self
            let imgUrl = tmpArrCommentDetails[indexPath.row].image
            let fname = tmpArrCommentDetails[indexPath.row].firstName
            let lname = tmpArrCommentDetails[indexPath.row].lastName
            homePostCommentTVCell?.lblUserName.text = "\(fname ?? "") \(lname ?? "")"
            homePostCommentTVCell?.imgProfilePicture.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
            homePostCommentTVCell?.lblCommentDescription.text = tmpArrCommentDetails[indexPath.row].comment
            //MARK:- set dayTimeDifference function after task complete
            var postTime = tmpArrCommentDetails[indexPath.row].createdAt ?? ""
            postTime.removeLast(5)
            homePostCommentTVCell?.lblCommentTime.text = postTime.timeInterval(timeAgo: postTime)
            if tmpArrCommentDetails[indexPath.row].parentId != 0 {
                homePostCommentTVCell?.constaintLeadingMainView.constant = ((homePostCommentTVCell?.imgProfilePicture.bounds.width ?? 0) + 19)
            }
            else{
                homePostCommentTVCell?.constaintLeadingMainView.constant = 19
            }
            return homePostCommentTVCell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}
//MARK:- Textfield deleagte methods
extension SelectedHomePostViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtHomePostComment.resignFirstResponder()
        if txtHomePostComment.text != ""{
            commentPostModel.dict.removeAll()
            commentPostModel.dict["comment"] = txtHomePostComment.text
            commentPostModel.dict["post_id"] = "\(self.arrDetails?.id ?? 0)"
            commentPostModel.dict["parent_id"] = "\(parentId)"
            commentPostModel.dict["is_delete"] = "\(0)"
            commentPostAPI()
        }
        self.setTextfieldPlaceholder(plceholderName: "Leave a comment...")
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.setTextfieldPlaceholder(plceholderName: "Leave a comment...")
        return true
    }
}
//MARK:- @objc function.
extension SelectedHomePostViewController: CommentReplyDelegate{
    func btnCommentReplyAction(indexPath: IndexPath) {
        if tmpArrCommentDetails[indexPath.row].parentId == 0{
            if let id = tmpArrCommentDetails[indexPath.row].id{
                self.parentId = id
            }
        }else{
            if let id = tmpArrCommentDetails[indexPath.row].parentId{
                self.parentId = id
            }
        }
        self.setTextfieldPlaceholder(plceholderName: "Reply to a comment...")
        txtHomePostComment.becomeFirstResponder()
    }
    @objc func refreshTableViewData() {
        self.getAllCommentCallAPI()
        self.refreshControl.endRefreshing()
    }
}
//MARK:- API call.
extension SelectedHomePostViewController{
    func getAllCommentCallAPI(){
        self.viewModel.postId = self.arrDetails?.id
        showActivityIndicator(uiView: self.view)
        viewModel.getAllCommentAPI { (isFinished, message) in
            self.tmpArrCommentDetails.removeAll()
            hideActivityIndicator(uiView: self.view)
            if isFinished
            {
                self.arrCommentDetails = self.viewModel.getAllComments
                _ = self.arrCommentDetails?.data?.compactMap({ (elements) in
                    if elements.childs?.count ?? 0 > 0{
                        self.tmpArrCommentDetails.append(AllCommets(id: elements.id, postId: elements.postId, userId: elements.userId, parentId: elements.parentId, firstName: elements.firstName, lastName: elements.lastName, image: elements.image, comment: elements.comment,createdAt: elements.createdAt))
                        _ = elements.childs?.compactMap({ (child) in
                            self.tmpArrCommentDetails.append(AllCommets(id: child.id, postId: child.postId, userId: child.userId, parentId: child.parentId, firstName: child.firstName, lastName: child.lastName, image: child.image, comment: child.comment, createdAt: child.createdAt))
                        })
                    }else{
                        self.tmpArrCommentDetails.append(AllCommets(id: elements.id, postId: elements.postId, userId: elements.userId, parentId: elements.parentId, firstName: elements.firstName, lastName: elements.lastName, image: elements.image, comment: elements.comment, createdAt: elements.createdAt))
                    }
                })
                self.tblSelectedHomePost.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    func commentPostAPI(){
        showActivityIndicator(uiView: self.view)
        commentPostModel.commentPostAPI{ (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.getAllCommentCallAPI()
                self.parentId = 0
                self.tblSelectedHomePost.reloadData()
                self.txtHomePostComment.text = ""
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- Play video using AVPlayer.
extension SelectedHomePostViewController: HomeFeedDelegate{
    func playSelectedVideo(url: String) {
        playVideo(videoUrl: url)
    }
    func btnseeMoreAction(indexPath: IndexPath) {
        if noOfLinefForDescriptionLabel == 0{
            noOfLinefForDescriptionLabel = 3
        }else{
            noOfLinefForDescriptionLabel = 0
        }
        self.tblSelectedHomePost.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
extension SelectedHomePostViewController: UpdateTableviewDataDelegate{
    func updateTableview(index: Int) {
        self.tblSelectedHomePost.reloadData()
    }
    func didPressSavedButton(indexPath: IndexPath) {}
    func didPressCommentButton(tag: IndexPath) {}
    func btnLike(indexPath: IndexPath) {}
    func btnShareAction(indexPath: IndexPath) {
        showShareActivity(url: "remuda://remuda.com/home-posts/\(arrDetails?.id ?? 0)")
    }
}
