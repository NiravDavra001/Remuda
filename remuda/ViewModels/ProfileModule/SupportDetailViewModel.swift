//
//  SupportDetailViewModel.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import UIKit

class SupportDetailViewModel: NSObject {
    var viewController : SupportDetailViewController?
    init(_ viewController : SupportDetailViewController){
        super.init()
        self.viewController = viewController
        setUpUI()
    }
    func setUpUI(){
        if viewController?.supportDetailText == .Terms_conditions{
            viewController?.title = "Terms and Conditions"
            LoadURL()
        }else if viewController?.supportDetailText == .privacy_policy{
            viewController?.title = "Privacy Policy"
            LoadURL()
        }else if viewController?.supportDetailText == .about_us{
            viewController?.title = "About US"
            LoadURL()
        }
    }
    func LoadURL(){
        showActivityIndicator(uiView: viewController?.view ?? UIView())
        if let url = URL(string: viewController?.supportDetailText.rawValue ?? ""){
            hideActivityIndicator(uiView: viewController?.view ?? UIView())
            viewController?.webView.load(URLRequest(url: url))
        }
    }
    func viewWillDisAppear(){
       // viewController?.navigationController?.navigationBar.backItem?.title = ""
    }
}
