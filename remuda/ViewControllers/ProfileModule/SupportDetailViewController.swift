//
//  SupportDetailViewController.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import UIKit
import WebKit

class SupportDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var mainView: UIView!
    var supportDetailText = SupportDetailData.Terms_conditions
    var supportDetailData : SupportDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        supportDetailData = SupportDetailViewModel(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        supportDetailData?.viewWillDisAppear()
    }
    
}
