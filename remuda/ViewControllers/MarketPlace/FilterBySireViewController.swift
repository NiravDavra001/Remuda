//
//  FilterBySireViewController.swift
//  remuda
//
//  Created by Macmini on 10/06/21.
//

import UIKit

class FilterBySireViewController: UIViewController {
    
    @IBOutlet var searchBarForNewCity: UISearchBar!
    @IBOutlet var tblPreviousSearchLocation: UITableView!
    var filterCategory = HorseFilter(rawValue: "")
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI(){
//        if filterCategory == HorseFilter.sire{
//            self.setNavigationBarSubVCTitle(navTitle: .FilterBySire)
//        }else
//        if filterCategory == HorseFilter.foalTo{
//            self.setNavigationBarSubVCTitle(navTitle: .FilterByFoalTo)
//        }
        self.setSearchBar()
        self.tblPreviousSearchLocation.dataSource = self
        self.tblPreviousSearchLocation.delegate = self
        self.tblPreviousSearchLocation.separatorStyle = .none
        self.tblPreviousSearchLocation.register(UINib(nibName: TableCellIdentifiers.PreviousLocationTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue)
    }
    func setSearchBar(){
        self.searchBarForNewCity.searchBarStyle = .minimal
        self.searchBarForNewCity.searchTextField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.searchBarForNewCity.searchTextField.leftView?.tintColor = .black
        self.searchBarForNewCity.tintColor = .black
        self.searchBarForNewCity.placeholder = "Search"
        self.searchBarForNewCity.barTintColor = .selectPhoto_background
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }

}

extension FilterBySireViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let previousLocationTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue) as? PreviousLocationTableViewCell
        previousLocationTVCell?.selectionStyle = .none
        return previousLocationTVCell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48 * UIScreen.main.bounds.height / 812
    }
}
