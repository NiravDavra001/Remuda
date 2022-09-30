//
//  viewController+Extentions.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MobileCoreServices


protocol SetSelectedImageDelegate {
    func setSelectedImage(image : UIImage)
}

extension UIViewController {
    
    func loadViewController(Storyboard:StoryBoardIdentifiers,ViewController:ViewControllerIdentifiers) -> UIViewController {
        let storyBoard = UIStoryboard(name: Storyboard.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewController.rawValue)
        return vc
    }
    
    ///     navigate To Push Cotroller
    func pushViewController( controllerID : ViewControllerIdentifiers,storyBoardID : StoryBoardIdentifiers) {
        let storyBoard = UIStoryboard(name: storyBoardID.rawValue, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: controllerID.rawValue)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    ///     navigate To Present Cotroller
    func presentViewController(controllerID : ViewControllerIdentifiers,storyBoardID : StoryBoardIdentifiers) {
        let storyBoard = UIStoryboard(name: storyBoardID.rawValue, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: controllerID.rawValue)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    ///    navigate To Previous View Controller
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    ///    dismiss View Controller
    func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    ///    to root viewController
    func popToRootViewController(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    ///  show Alert Of Messg
    func showAlert(message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //SHow alert for update App
    func updateAppAlert(_ msg: String, Title: String) -> UIAlertController{
        
        let alert = UIAlertController(title: "Remuda", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Title, style: UIAlertAction.Style.default, handler: { (alert) in
            if let url = URL(string: "https://apps.apple.com/us/app/remuda/id1564561434") {
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [ : ], completionHandler: nil)
                }else{
                    print("Not open appstore")
                }
            }
        }))
        
        return alert
    }
    func setBackButtonTitleHide(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
    }
    
    func setBackButton(){
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_navigation")
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_navigation")
    }
    
    func setCustomnavigationButton(targetDone:Any, selectorDone: Selector, targetCancel:Any, selectorCancel: Selector){
        let btnDone = UIButton()
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(.app_green_color, for: .normal)
        btnDone.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnDone.addTarget(targetDone, action: selectorDone, for: .touchUpInside)
        btnDone.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item = UIBarButtonItem()
        item.customView = btnDone
        self.navigationItem.rightBarButtonItems = [item]
        
        let btnCancel = UIButton()
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(.app_green_color, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnCancel.addTarget(targetCancel, action: selectorCancel, for: .touchUpInside)
        btnCancel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item1 = UIBarButtonItem()
        item1.customView = btnCancel
        self.navigationItem.leftBarButtonItem = item1
    }
    
    func setNavigationBarSubVCTitle(navTitle: ViewControllerTitle){
        self.title = navTitle.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        self.setBackButtonTitleHide()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 40 * UIScreen.main.bounds.height/812 ))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func playVideo(videoUrl: String) {
        let playerViewController = AVPlayerViewController()
        var playerView = AVPlayer()
        let url: URL = URL(string: videoUrl)!
        playerView = AVPlayer(url: url)
        playerViewController.player = playerView
        self.present(playerViewController, animated: true, completion: nil)
        playerViewController.player?.play()
    }
    
    //MARK:- showShareActivity
    func showShareActivity(url:String?){
        var objectsToShare = [AnyObject]()
        
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true, completion: nil)
    }
    
}
