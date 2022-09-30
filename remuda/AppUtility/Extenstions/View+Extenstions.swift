//
//  View+Extenstions.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

extension UIView{
    
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func setBorder( _ width : CGFloat ,_ borderColour : UIColor? = nil ,_ cornerRadius : CGFloat? = 0){
        self.layer.borderWidth = width
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius ?? 0
        if borderColour != nil{
            self.layer.borderColor = borderColour!.cgColor
        }
        else{
            self.layer.borderColor = borderColour?.cgColor
        }
    }
    
    func setMarketPlaceCellGradient() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor , UIColor.black.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.33,0.66,1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    func setMarketPlaceSavedCellGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor , UIColor.black.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.50,0.50,1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setUpCornerRadius( _ radius : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRoundedView(){
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyShodowToBottom(){
        let shadowSize: CGFloat = 20
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        self.layer.shadowOpacity = 1
        let contactRect = CGRect(x: 0, y: 0, width: self.bounds.width, height: shadowSize)
        self.layer.shadowPath = UIBezierPath(roundedRect: contactRect, cornerRadius: 0).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    func manageKeyboard(){
        let tap = UITapGestureRecognizer(target: self,action:#selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func txtSetBorderForPersonalInformation(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.personalInformationBorder.cgColor
    }
    
    func dropShadow(){
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}

