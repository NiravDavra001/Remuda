//
//  HorseFilterByLocationViewController.swift
//  remuda
//
//  Created by Macmini on 09/06/21.
//

import UIKit
import GooglePlaces

class HorseFilterByLocationViewController: UIViewController {
    
    @IBOutlet var searchBarForNewCity: UISearchBar!
    @IBOutlet var imgGeography: UIButton!
    @IBOutlet var lblWithImg: UILabel!
    @IBOutlet var tblPreviousSearchLocation: UITableView!
    private var placesClient: GMSPlacesClient!
    var arrContry = [String]()
    var searching = false
    var delegate: FilterByLocationDelegate?
    var mode: MarketPlaceMode?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesClient = GMSPlacesClient.shared()
        self.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationBar()
        self.tblPreviousSearchLocation.reloadData()
    }
    func setUpNavigationBar(){
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.setBackButtonTitleHide()
    self.setBackButton()
    }
    func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .filterByLocation)
        tblPreviousSearchLocation.dataSource = self
        tblPreviousSearchLocation.delegate = self
        tblPreviousSearchLocation.separatorStyle = .none
        tblPreviousSearchLocation.register(UINib(nibName: TableCellIdentifiers.PreviousLocationTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue)
        self.setSearchBar()
        lblWithImg.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        lblWithImg.textColor = .app_green_color
    }
    func setSearchBar(){
        searchBarForNewCity.delegate = self
        searchBarForNewCity.searchBarStyle = .minimal
        searchBarForNewCity.searchTextField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        searchBarForNewCity.searchTextField.leftView?.tintColor = .black
        searchBarForNewCity.tintColor = .black
        searchBarForNewCity.placeholder = "Search"
        searchBarForNewCity.barTintColor = .selectPhoto_background
    }
    @IBAction func showAllLocationAction(_ sender: UIButton) {
        filterTackByLocation.removeAll()
        filterHorseByLocation.removeAll()
        filterEquipmentByLocation.removeAll()
        popViewController()
    }
}

extension HorseFilterByLocationViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searching {
        case true:
            return arrContry.count
        case false:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let previousLocationTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue) as? PreviousLocationTableViewCell
        previousLocationTVCell?.selectionStyle = .none
        switch searching {
        case true:
            previousLocationTVCell?.lblLocationName.text = arrContry[indexPath.row]
            return previousLocationTVCell ?? UITableViewCell()
        case false:
            return previousLocationTVCell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousLocationTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue) as? PreviousLocationTableViewCell
        previousLocationTVCell?.selectionStyle = .none
        switch searching {
        case true:
            switch self.mode {
            case .horse:
                filterHorseByLocation = arrContry[indexPath.row]
                popViewController()
            case .equipmment:
                filterEquipmentByLocation = arrContry[indexPath.row]
                popViewController()
            case .tack:
                filterTackByLocation = arrContry[indexPath.row]
                popViewController()
            default:
                break
            }
            
        case false:
            print("false")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48 * UIScreen.main.bounds.height / 812
    }
    
}

extension HorseFilterByLocationViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        self.placeAutocomplete(searchTxt: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        view.endEditing(true)
        tblPreviousSearchLocation.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tblPreviousSearchLocation.reloadData()
    }
    func placeAutocomplete(searchTxt : String) { //Call function from your search editing method
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        //"YOUR_SEARCH_DATA" Ex. Sydney Oper
        //Uou will get data for  city sydney
        placesClient?.findAutocompletePredictions(fromQuery: searchTxt , filter: filter, sessionToken: nil, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            self.arrContry.removeAll()
            for result in results ?? [GMSAutocompletePrediction](){
                if let result = result as? GMSAutocompletePrediction {
                    self.arrContry.append((result.attributedFullText.string) )
                }
            }
//            self.arrContry = self.arrContry.filter({$0.contains(searchTxt)})
            self.searching = true
            self.tblPreviousSearchLocation.reloadData()
            if self.arrContry.count == 0{
                self.tblPreviousSearchLocation.setEmptyMessage("Data Not Found")
            }else{
                self.tblPreviousSearchLocation.setEmptyMessage("")
            }
        })
    }
}
