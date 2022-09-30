//
//  PostGalleryViewController.swift
//  remuda
//
//  Created by mac on 31/08/21.
//

import UIKit
import AVKit
import AVFoundation

class PostGalleryViewController: UIViewController {
    @IBOutlet weak var postGalleryCollectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var closebutton: UIButton!
    var imageURLData: [String]?
    var index = IndexPath()
    var arrDetails : PostsModel?
    var videoURLData: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        postGalleryCollectionView.delegate = self
        postGalleryCollectionView.dataSource = self
        self.postGalleryCollectionView.register(UINib(nibName: CollectionCellIdentifiers.PostGalleryCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.PostGalleryCollectionViewCell.rawValue)
    }
    @IBAction func closebuttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension PostGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.PostGalleryCollectionViewCell.rawValue, for: indexPath) as! PostGalleryCollectionViewCell
        if index.row != indexPath.row {
            self.postGalleryCollectionView.scrollToItem(at: index, at: .right, animated: false)
        }
       
        let type = self.imageURLData?[indexPath.row].components(separatedBy: ".")
        let fileType = getFileExetantions(fileType: type?.last ?? "")
        if fileType == 0{
            cell.btnPlay.isHidden = true
            cell.photoGalleryImageView.sd_setImage(with: URL(string: self.imageURLData?[indexPath.row] ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }else if fileType == 1{
            cell.btnPlay.isHidden = false
//            let video = arrDetails?.data?[index.row].thumbnail
//            let videoThumbnialArray : [String] = video?.components(separatedBy: ",") ?? []
//            videoURLData = videoThumbnialArray
            cell.photoGalleryImageView.sd_setImage(with: URL(string: self.videoURLData?[indexPath.row] ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        cell.indexPath = index
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = postGalleryCollectionView.bounds.width
        let height = postGalleryCollectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension PostGalleryViewController: postGalleryVideoDelegate{
    func PostVideoPlay(indexPath: IndexPath) {
        let url = self.imageURLData?[indexPath.row] ?? ""
        self.playVideo(videoUrl: url)
    }
}
