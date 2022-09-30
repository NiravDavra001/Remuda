//
//  PostGalleryCollectionViewCell.swift
//  remuda
//
//  Created by mac on 31/08/21.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import ImageViewer_swift
protocol postGalleryVideoDelegate {
    func PostVideoPlay(indexPath: IndexPath)
}
class PostGalleryCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate  {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var photoGalleryImageView: UIImageView!
    
    var indexPath = IndexPath()
    var imageURLData =  [String]()
    var delegate : postGalleryVideoDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPlay.setUpCornerRadius(btnPlay.frame.size.height / 2)
        photoGalleryImageView.isUserInteractionEnabled = true
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchHandler(gesture:)))
        photoGalleryImageView.addGestureRecognizer(pinch)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 2
        photoGalleryImageView.addGestureRecognizer(tap)
        scrollView.contentOffset = CGPoint(x: 500, y: 1200)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 25.0
        scrollView.zoomScale = 1.0
        self.scrollView.delegate = self
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        zoomOut(self.scrollView)
    }
    @IBAction func btnPlayAction(_ sender: Any) {
        delegate?.PostVideoPlay(indexPath: self.indexPath)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoGalleryImageView
    }
    func zoomOut(_ imageScrollView:UIScrollView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scalFactor = scalFactor - 1
            if(scalFactor <= 1){
                scalFactor = 1
            }
            if(scalFactor > 0){
                UIView.animate(withDuration: 0.3, animations: {
                    imageScrollView.setZoomScale(CGFloat(scalFactor), animated: true)
                })
                
            }else{
                scalFactor = 1
                UIView.animate(withDuration: 0.3, animations: {
                    imageScrollView.setZoomScale(CGFloat(1), animated: true)
                    
                })
            }
        }
    }
    @objc private func pinchHandler(gesture: UIPinchGestureRecognizer) {
        if let view = gesture.view {
            switch gesture.state {
            case .changed:
                let pinchCenter = CGPoint(x: gesture.location(in: view).x - view.bounds.midX,
                                          y: gesture.location(in: view).y - view.bounds.midY)
                let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                    .scaledBy(x: gesture.scale, y: gesture.scale)
                    .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
                view.transform = transform
                gesture.scale = 1
            case .ended:
                UIView.animate(withDuration: 0.2, animations: {
                    view.transform = CGAffineTransform.identity
                })
            default:
                return
            }
        }
    }
}
