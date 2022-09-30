//
//  SignOutFooter.swift
//  remuda
//
//  Created by Macmini on 12/04/21.
//

import UIKit

class SignOutFooter: UITableViewHeaderFooterView {

    @IBOutlet var btnSignOut: UIButton!
    var delegate: TableviewReloadDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI(){
        self.btnSignOut.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        delegate?.signOut()
    }
    

}
