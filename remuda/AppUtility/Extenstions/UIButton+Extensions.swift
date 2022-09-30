//
//  UIButton+Extensions.swift
//  remuda
//
//  Created by Macmini on 08/06/21.
//

import Foundation
import UIKit

//class AppButton: UIButton {
//    
//    var isSetBorderFlag:Bool = false
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setUp()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.setUp()
//    }
//    func setUp(){
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.titleLabel?.font = UIFont(name: "Palatino", size: 20)
//        self.layer.cornerRadius = self.frame.height / 2.2
//    }
//    override func draw(_ rect: CGRect) {
//        self.layer.cornerRadius = self.frame.height / 2.2
//        self.clipsToBounds = true
//        self.applyGradient(colours: [ colorLiteral(red: 0.4039215686, green: 0.8509803922, blue: 0.9450980392, alpha: 1), colorLiteral(red: 0.2117647059, green: 0.6274509804, blue: 0.8078431373, alpha: 1)])
//        if isSetBorder{
//            self.applyBoder(borderWidth: 1, color: UIColor.white)
//        }
//        self.superview?.bringSubviewToFront(self)
//    }
//    @IBInspectable var isSetBorder: Bool = false {
//        didSet{
//            self.isSetBorderFlag = isSetBorder
//        }
//    }
//}
