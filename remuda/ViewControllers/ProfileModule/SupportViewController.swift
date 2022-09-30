//
//  SupportViewController.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import UIKit

class SupportViewController: UIViewController {

    @IBOutlet weak var supportTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    var supportData : SupportViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        supportData = SupportViewModel(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        supportData?.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        supportData?.viewWillDisAppear()
    }
}
