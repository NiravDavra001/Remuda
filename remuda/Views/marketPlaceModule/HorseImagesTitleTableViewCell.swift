//
//  HorseImagesTitleTableViewCell.swift
//  remuda
//
//  Created by mac on 14/04/21.
//

import UIKit

class HorseImagesTitleTableViewCell: UITableViewCell {

    @IBOutlet var imagePageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var playVideoDelegate: HomeFeedDelegate?
    var currentPage = 0
    var imageName = String()
    var imageURL: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imagePageController.isHidden = true
        collectionView.register(UINib(nibName: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

extension HorseImagesTitleTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURL?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.HomeFeedImageVideoCVCell.rawValue, for: indexPath) as! HomeFeedImageVideoCollectionViewCell
        
        self.imagePageController.numberOfPages = imageURL?.count ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            if self.imagePageController.numberOfPages > 1{
                self.imagePageController.isHidden = false
            }
        }
        let type = self.imageURL?[indexPath.row].components(separatedBy: ".")
        if type?.last == "jpeg"{
            cell.btnPlay.isHidden = true
            cell.homeFeedimageView.sd_setImage(with: URL(string: self.imageURL?[indexPath.row] ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }else if type?.last == "MOV"{
            cell.btnPlay.isHidden = false
            cell.homeFeedimageView.sd_setImage(with: URL(string: self.imageName), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        }
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.bounds.size
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
        self.imagePageController.currentPage = self.currentPage
    }
}

extension HorseImagesTitleTableViewCell: HomeFeedVideoPlayDelegate{
    func playVideo(indexPath: IndexPath) {
        let url = self.imageURL?[indexPath.row] ?? ""
        self.playVideoDelegate?.playSelectedVideo(url: url)
    }
}
