//
//  HomeFeedImageVideoCollectionViewCell.swift
//  remuda
//
//  Created by Macmini on 08/07/21.
//
protocol HomeFeedVideoPlayDelegate {
    func playVideo(indexPath: IndexPath)
}
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import ImageViewer_swift

class HomeFeedImageVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var homeFeedimageView: UIImageView!
    
    var indexPath = IndexPath()
    var imageURLData =  [String]()
    var delegate: HomeFeedVideoPlayDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        delegate?.playVideo(indexPath: self.indexPath)
    }
}
