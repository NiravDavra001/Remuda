//
//  ViewController.swift
//  remuda
//
//  Created by mac on 31/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblAlready: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpUI()
    }

    func setUpNavigationController(){
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_navigation")
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_navigation")
    }
    
    func setUpUI(){
        imageView.alpha = 0.6
        lblWelcome.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_28))
        lblTagLine.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblAlready.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSignUp.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblWelcome.textColor = .white
        lblTagLine.textColor = .white
        lblAlready.textColor = .white
        btnSignUp.setTitleColor(.white, for: .normal)
        
        lblAlready.isUserInteractionEnabled = true
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.onClickSignUpTouchupInside(_:)))
        lblAlready.addGestureRecognizer(labelTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnSignUp.setUpCornerRadius(5)
    }
    
    @IBAction func onTapSinginTouchUpInside(_ sender: UIButton){
        if UserDefaultManager.share.getBoolUserDefaultValue(key: .isVersionUpadted){
            self.pushViewController( controllerID :.CreateAccountVC ,storyBoardID : .Main)
        }else{
            self.present(updateAppAlert("Please update app to App Store.", Title: "Update"), animated: true, completion: nil)
        }
    }
    
    @objc func onClickSignUpTouchupInside(_ sender: UITapGestureRecognizer){
        let termsRange = (lblAlready.text! as NSString).range(of: "Sign In")
        if sender.didTapAttributedTextInLabel(label: lblAlready, inRange: termsRange),UserDefaultManager.share.getBoolUserDefaultValue(key: .isVersionUpadted) {
            self.pushViewController(controllerID: .SignInVC, storyBoardID: .Main)
        }else{
            self.present(updateAppAlert("Please update app to App Store.", Title: "Update"), animated: true, completion: nil)
        }
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
