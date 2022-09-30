//
//  HeadMobileNoViewController.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import UIKit

protocol HeadMobileNoViewControllerDelegate {
    func setCountryCode(code : String, completion: @escaping () -> ())
}

class HeadMobileNoViewController: UIViewController {
    
    @IBOutlet var searchBarCountryCode: UISearchBar!
    @IBOutlet weak var tableView : UITableView!
    
    var arrPhoneCode = [ContryCodeModel]()
    var searchedArrPhoneCode = [ContryCodeModel]()
    var isSearching = false
    
    var delegate : HeadMobileNoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarCountryCode.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CountryCodeTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryCodeTableViewCell")
        tableView.register(UINib(nibName: "SearchCountryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCountryTableViewCell")
        readCountryCodes()
    }
    
    func readCountryCodes(){
        if let path = Bundle.main.path(forResource: "CountryCode", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let result = jsonResult as? [Dictionary<String, Any>] {
                    for i in 0..<(result.count){
                        arrPhoneCode.append(ContryCodeModel(fromDictionary: result[i]))
                        tableView.reloadData()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func btnDismissTableview(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HeadMobileNoViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchedArrPhoneCode.count
        }else{
            return arrPhoneCode.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeTableViewCell", for: indexPath) as! CountryCodeTableViewCell
        if isSearching{
            cell.countryCode.text = searchedArrPhoneCode[indexPath.row].iso
            cell.countryName.text = searchedArrPhoneCode[indexPath.row].name
            return cell
        }else{
            cell.countryCode.text = arrPhoneCode[indexPath.row].iso
            cell.countryName.text = arrPhoneCode[indexPath.row].name
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            self.delegate?.setCountryCode(code: searchedArrPhoneCode[indexPath.row].iso, completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.delegate?.setCountryCode(code: arrPhoneCode[indexPath.row].iso, completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}

extension HeadMobileNoViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedArrPhoneCode = arrPhoneCode.filter({$0.name.prefix(searchText.count) == searchText})
        isSearching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
