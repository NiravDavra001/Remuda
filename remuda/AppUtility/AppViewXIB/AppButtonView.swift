//
//  AppButtonView.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import UIKit

class AppButtonView: UIView {
    
    
    
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setUpUI()
    }
    
    func setUpUI(){
        Button.tintColor = .white
        Button.setTitleColor(.white, for: .normal)
        Button.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.backgroundColor = .app_button_backgound_color
    }
    
    func setButtonTitleColor(color : UIColor){
        Button.setTitleColor(color, for: .normal)
    }
    
    func setButton(name : String,imageName : String? = nil){
        if imageName != "" || imageName != nil{
            image.image = UIImage(named: imageName ?? "")
        }
        Button.setTitle(name, for: .normal)
        
    }
    
    
    func setButtonNameRightSide(){
        Button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -30)
    }
    
//    func setImageGradient(){
//        image.setImageGradient(LeftColor: .appDarkGreen, RightColor: .appLightGreen)
//    }
    
    override func draw(_ rect: CGRect) {
//        self.setRoundedView()
//        Button.setRoundedView()
    }
    
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "AppButtonView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }

}
