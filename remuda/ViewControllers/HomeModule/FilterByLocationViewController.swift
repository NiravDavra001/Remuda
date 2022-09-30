//
//  FilterByLocationViewController.swift
//  remuda
//
//  Created by Macmini on 22/04/21.
//
protocol FilterByLocationDelegate {
    func filterByLocation(city: String)
}
import UIKit
import GooglePlaces

class FilterByLocationViewController: UIViewController {
    
    @IBOutlet var btnShowAllPost: UIButton!
    @IBOutlet var previousView: UIView!
    @IBOutlet var lblPreviosSearch: UILabel!
    @IBOutlet var searchBarForNewCity: UISearchBar!
    @IBOutlet var imgGeography: UIButton!
    @IBOutlet var lblWithImg: UILabel!
    @IBOutlet var tblPreviousSearchLocation: UITableView!
    private var placesClient: GMSPlacesClient!
    var arrContry = [String]()
    var arrPreviousSearch = [String]()
    var searching = false
    var delegate: FilterByLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpData()
        self.searchBarSetUp()
        self.setUpTableview()
        self.placesClient = GMSPlacesClient.shared()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    private func setUpData() {
        self.title = ViewControllerTitle.filterByLocation.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        let arrSearch = UserDefaults.standard.object(forKey: UserDefaultModelKeys.storePreviousSearch.rawValue)
        arrPreviousSearch = arrSearch as? [String] ?? []
    }
    private func setUpUI(){
        self.lblPreviosSearch.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        self.lblWithImg.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.lblWithImg.textColor = .app_green_color
    }
    private func setUpTableview() {
        self.tblPreviousSearchLocation.dataSource = self
        self.tblPreviousSearchLocation.delegate = self
        self.tblPreviousSearchLocation.separatorStyle = .none
        self.tblPreviousSearchLocation.register(UINib(nibName: TableCellIdentifiers.PreviousLocationTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue)
    }
    func searchBarSetUp(){
        self.searchBarForNewCity.delegate = self
        self.searchBarForNewCity.searchBarStyle = .minimal
        self.searchBarForNewCity.searchTextField.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.searchBarForNewCity.searchTextField.leftView?.tintColor = .black
        self.searchBarForNewCity.tintColor = .black
        self.searchBarForNewCity.placeholder = "Search for a new city"
        self.searchBarForNewCity.barTintColor = .selectPhoto_background
    }
    
    @IBAction func btnShowAllPost(_ sender: UIButton) {
        self.popViewController()
    }
}

extension FilterByLocationViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return arrContry.count
        }else{
            return arrPreviousSearch.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let previousLocationTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PreviousLocationTVCell.rawValue) as! PreviousLocationTableViewCell
        previousLocationTVCell.selectionStyle = .none
        if searching{
            self.previousView.isHidden = true
            previousLocationTVCell.lblLocationName.text = arrContry[indexPath.row]
            return previousLocationTVCell
        }else{
            self.previousView.isHidden = false
            previousLocationTVCell.lblLocationName.text = arrPreviousSearch[(arrPreviousSearch.count - 1) - indexPath.row]
            return previousLocationTVCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            if arrPreviousSearch.contains(arrContry[indexPath.row]){
                delegate?.filterByLocation(city: arrContry[indexPath.row])
                popViewController()
            }else{
                if arrPreviousSearch.count<4{
                    arrPreviousSearch.append(arrContry[indexPath.row])
                    UserDefaults.standard.set(arrPreviousSearch, forKey: UserDefaultModelKeys.storePreviousSearch.rawValue)
                    view.endEditing(true)
                    delegate?.filterByLocation(city: arrContry[indexPath.row])
                    popViewController()
                }else{
                    arrPreviousSearch.removeFirst()
                    arrPreviousSearch.append(arrContry[indexPath.row])
                    UserDefaults.standard.set(arrPreviousSearch, forKey: UserDefaultModelKeys.storePreviousSearch.rawValue)
                    view.endEditing(true)
                    delegate?.filterByLocation(city: arrContry[indexPath.row])
                    popViewController()
                }
            }
        }else{
            delegate?.filterByLocation(city: arrPreviousSearch[(arrPreviousSearch.count - 1) - indexPath.row])
            popViewController()
        }
    }
}

extension FilterByLocationViewController: UISearchBarDelegate {
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
                self.tblPreviousSearchLocation.setEmptyMessage("There is no posts in this location")
            }else{
                self.tblPreviousSearchLocation.setEmptyMessage("")
            }
        })
    }
}

