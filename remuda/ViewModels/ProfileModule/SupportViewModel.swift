//
//  SupportViewModel.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import UIKit

class SupportViewModel: NSObject {
    var viewController : SupportViewController?
    var supportData = [SupportModel]()
    
    init(_ viewController: SupportViewController){
        super.init()
        self.viewController = viewController
        setUpUI()
    }
    func setUpUI(){
        viewController?.supportTableView.delegate = self
        viewController?.supportTableView.dataSource = self
        viewController?.navigationController?.setNavigationBarHidden(false, animated: false)
        viewController?.supportTableView.register(UINib(nibName: TableCellIdentifiers.supportListTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.supportListTVCell.rawValue)
        supportData = [SupportModel(title: .terms_conditions), SupportModel(title: .privacy_policy), SupportModel(title: .about_us)]
        viewController?.title = ViewControllerTitle.support.rawValue
    }
    func viewWillDisAppear(){
        viewController?.title = ""
    }
    func viewWillAppear(){
        viewController?.title = ViewControllerTitle.support.rawValue
    }
}
extension SupportViewModel : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.supportListTVCell.rawValue, for: indexPath) as! SupportListTableViewCell
        cell.titleLabel.text = supportData[indexPath.row].title.rawValue
      return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch supportData[indexPath.row].title {
        case .terms_conditions:
            let vc = viewController?.loadViewController(Storyboard: .Profile, ViewController: .supportDetailVC) as! SupportDetailViewController
            vc.supportDetailText = .Terms_conditions
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .privacy_policy:
            let vc = viewController?.loadViewController(Storyboard: .Profile, ViewController: .supportDetailVC) as! SupportDetailViewController
            vc.supportDetailText = .privacy_policy
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .about_us:
            let vc = viewController?.loadViewController(Storyboard: .Profile, ViewController: .supportDetailVC) as! SupportDetailViewController
            vc.supportDetailText = .about_us
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
