//
//  HomePostsTableViewCell.swift
//  remuda
//
//  Created by mac on 09/04/21.
//
protocol HomeFeedDelegate {
    func playSelectedVideo(url: String)
    func btnseeMoreAction(indexPath: IndexPath)
}

struct ImageDemo {
    var imageData : [String]?
    var videoData : [String]?
}

protocol PhotoGalleryDelegate {
    func photoGalleryAction(indexPath: IndexPath?, arrGalleryItem: [String]?, videoData: [String]?)
}

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import ImageViewer_swift
import SDWebImage

class HomePostsTableViewCell: UITableViewCell {
    
    @IBOutlet var btnShare: UIButton!
    @IBOutlet var feedPageController: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var postedUserimage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblPostTextDetail: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var lblCommentCount: UILabel!
    @IBOutlet var lblSaved: UILabel!
    @IBOutlet var lblShare: UILabel!
    @IBOutlet var viewForImageView: UIView!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnSaved: UIButton!
    var currentPage = 0
    var playVideoDelegate: HomeFeedDelegate?
    var indexPath = IndexPath()
    var isLabelAtMaxHeight = false
    var delegate: UpdateTableviewDataDelegate?
    var photoGalleryDelegate: PhotoGalleryDelegate?
    var index: Int!
    let unlikedImage = UIImage(named: "Unlike")
    let likedImage = UIImage(named: "like")
    var isLiked = true
    var viewModel = SaveLikeViewModel()
    var imageURLData: [String]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var imgData : ImageDemo?
    
    var videoURLData: [String]?
    var tmpVideoURLData: [String]?
    var imageData: [Data]?
    var message: String?{
        didSet{
            self.layoutIfNeeded()
            self.lblPostTextDetail.text = message
            
            if message != "" {
                if  lblPostTextDetail.text?.maximulNoOfLines(desLabel: lblPostTextDetail) ?? 0 > lblPostTextDetail.numberOfLines{
                    DispatchQueue.main.async {
                        if self.lblPostTextDetail.text?.maximulNoOfLines(desLabel: self.lblPostTextDetail) ?? 0 >= 3 {
                            if self.lblPostTextDetail.numberOfLines == 3{
                                self.lblPostTextDetail.addTrailing(with: "... ", moreText: "see more", moreTextFont: UIFont.systemFont(ofSize: 15.0), moreTextColor: UIColor.link)
                            }else{
                                self.lblPostTextDetail.addTrailing(with: "... ", moreText: "see less", moreTextFont: UIFont.systemFont(ofSize: 15.0), moreTextColor: UIColor.link)
                            }
                        }
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTermTapped))
                        self.lblPostTextDetail.isUserInteractionEnabled = true
                        self.lblPostTextDetail.addGestureRecognizer(tap)
                    }
                }
            }
            
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLabelTap()
        self.setUpUI()
        self.setCollectionView()
    }
    func setCollectionView() {
        self.collectionView.isPagingEnabled = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        postedUserimage.setRoundedView()
        self.feedPageController.isHidden = true
    }
    
    func setupLabelTap() {
        
        let labelCommentCount = UITapGestureRecognizer(target: self, action: #selector(self.labelCommentCountTapped(_:)))
        self.lblCommentCount.isUserInteractionEnabled = true
        self.lblCommentCount.addGestureRecognizer(labelCommentCount)
        
        let labelShare = UITapGestureRecognizer(target: self, action: #selector(self.labelShareTapped(_:)))
        self.lblShare.isUserInteractionEnabled = true
        self.lblShare.addGestureRecognizer(labelShare)
        
        let labelSaved = UITapGestureRecognizer(target: self, action: #selector(self.labelSavedTapped(_:)))
        self.lblSaved.isUserInteractionEnabled = true
        self.lblSaved.addGestureRecognizer(labelSaved)
        
        let labelLike = UITapGestureRecognizer(target: self, action: #selector(self.labelLikeTapped(_:)))
        self.lblLikeCount.isUserInteractionEnabled = true
        self.lblLikeCount.addGestureRecognizer(labelLike)
        
    }
    
    func setUpUI(){
        
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblPostTextDetail.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        lblTime.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        lblTime.textColor = .label_bookmarks_postGrey_color
        lblLikeCount.setSemiBold13SizeFont()
        lblCommentCount.setSemiBold13SizeFont()
        lblSaved.setSemiBold13SizeFont()
        lblShare.setSemiBold13SizeFont()
    }
    
    //MARK:- see more and see less label tap gesture.
    @objc func handleTermTapped(gesture: UITapGestureRecognizer) {
        
        guard let fullstring: NSString = lblPostTextDetail.attributedText?.string as NSString? else{
            return
        }
        var termRange = NSRange()
        if self.lblPostTextDetail.numberOfLines == 0{
            termRange = fullstring.range(of: "... see less")
        }else{
            termRange = fullstring.range(of: "... see more")
        }
        
        let tapLocation = gesture.location(in: lblPostTextDetail)
        let index = lblPostTextDetail.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
        
        if checkRange(termRange, contain: index) == true {
            self.playVideoDelegate?.btnseeMoreAction(indexPath: self.indexPath)
            return
        }
    }
    func checkRange(_ range: NSRange, contain index: Int) -> Bool {
        return index > range.location && index < range.location + range.length
    }
    func getLabelHeight(text: String, width: CGFloat) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        return lbl.frame.size.height
    }
    @objc func labelCommentCountTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didPressCommentButton(tag: self.indexPath)
    }
    @objc func labelShareTapped(_ sender: UITapGestureRecognizer) {
        delegate?.btnShareAction(indexPath: self.indexPath)
    }
    @objc func labelLikeTapped(_ sender: UITapGestureRecognizer) {
        delegate?.btnLike(indexPath: self.indexPath)
    }
    @objc func labelSavedTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didPressSavedButton(indexPath: self.indexPath)
    }
    
    //MARK:- UIButton Actions.
    @IBAction func btnLike(_ sender: Any) {
        delegate?.btnLike(indexPath: self.indexPath)
    }
    @IBAction func btnCommentClick(_ sender: UIButton) {
        delegate?.didPressCommentButton(tag: self.indexPath)
    }
    @IBAction func btnSaved(_ sender: UIButton) {
        delegate?.didPressSavedButton(indexPath: self.indexPath)
    }
    @IBAction func btnShareAction(_ sender: UIButton) {
        delegate?.btnShareAction(indexPath: self.indexPath)
    }
}

extension HomePostsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue, for: indexPath) as! HomeFeedImageVideoCollectionViewCell
        cell.imageURLData = imageURLData ?? [""]
       // cell.setUPImageData()
        self.feedPageController.numberOfPages = imageURLData?.count ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            if self.feedPageController.numberOfPages > 1{
                self.feedPageController.isHidden = false
            }
        }
        let type = self.imageURLData?[indexPath.row].components(separatedBy: ".")
        let fileType = getFileExetantions(fileType: type?.last ?? "")
        if fileType == 0{
            cell.btnPlay.isHidden = true
            cell.homeFeedimageView.sd_setImage(with: URL(string: self.videoURLData?[indexPath.row] ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }else if fileType == 1{
            cell.btnPlay.isHidden = false
            cell.homeFeedimageView.sd_setImage(with: URL(string: self.videoURLData?[indexPath.row] ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width
        let height = self.collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.feedPageController.currentPage = self.currentPage
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionview didselect")
        photoGalleryDelegate?.photoGalleryAction(indexPath: indexPath, arrGalleryItem: imageURLData, videoData: videoURLData)
    }
}

extension HomePostsTableViewCell: HomeFeedVideoPlayDelegate{
    func playVideo(indexPath: IndexPath) {
        let url = self.imageURLData?[indexPath.row] ?? ""
        self.playVideoDelegate?.playSelectedVideo(url: url)
    }
}

