//
//  WebViewViewController.swift
//  remuda
//
//  Created by Macmini on 16/07/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    var url: URL?
    var webTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.load(URLRequest(url: self.url!))
        self.title = self.webTitle
    }
}
