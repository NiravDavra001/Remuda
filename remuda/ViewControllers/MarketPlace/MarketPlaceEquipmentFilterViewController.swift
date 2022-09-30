//
//  MarketPlaceEquipmentFilterViewController.swift
//  remuda
//
//  Created by Macmini on 22/06/21.
//
enum EquipmentFilter: String{
    case location  = "Location"
    case condition = "Condition"
    case price  = "Price"
}
struct EquipmentFilterModel {
    var category: EquipmentFilter
}
protocol ApplyEquipmentFilterDelegate {
    func filterEquipmentData()
}
import UIKit

class MarketPlaceEquipmentFilterViewController: UIViewController {
    @IBOutlet var generalView: CustomPickerView!
    @IBOutlet var btnApplyFilter: UIButton!
    @IBOutlet var tblView: UITableView!
    var arrEquipmentFilter = [EquipmentFilterModel]()
    var category = String()
    var arrMinPrice = [String]()
    var delegate: ApplyEquipmentFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationBar()
        self.tblView.reloadData()
    }
    func setUpNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
        self.setResetButton()
    }
    func setResetButton(){
        let btn = UIButton()
        btn.setTitle("Reset", for: .normal)
        btn.setTitleColor(.app_green_color, for: .normal)
        btn.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btn.addTarget(self, action: #selector(btnResetTap(sender:)), for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.rightBarButtonItems = [item]
    }
    @objc func btnResetTap(sender: UIBarButtonItem) {
        filterEquipmentMinPrice = nil
        filterEquipmentMaxPrice = nil
        filterEquipmentByLocation = ""
        filterConditionData.removeAll()
        horseFilterData = tmpHorseFilterData
        self.tblView.reloadData()
    }
    func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .EquipmentFilter)
        btnApplyFilter.tintColor = .white
        btnApplyFilter.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.generalView.btnCancel.addTarget(self, action: #selector(btnPickerCancel(sender:)), for: .touchUpInside)
        self.generalView.tbnDone.addTarget(self, action: #selector(btnPickerDone(sender:)), for: .touchUpInside)
        tblView.dataSource = self
        tblView.delegate = self
        tblView.register(UINib(nibName: TableCellIdentifiers.FilterHorseTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue)
        
        arrEquipmentFilter = [
            EquipmentFilterModel(category: .location),
            EquipmentFilterModel(category: .condition),
            EquipmentFilterModel(category: .price)
        ]
    }
    @objc func btnPickerCancel(sender: UIButton){
        self.generalView.isHidden = true
    }
    @objc func btnPickerDone(sender: UIButton){
        if category == EquipmentFilter.price.rawValue
        {
            if filterEquipmentMinPrice == nil && filterEquipmentMaxPrice == nil{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }else{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }
        }else{
            self.generalView.isHidden = true
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnApplyFilter.setUpCornerRadius(5)
    }
    @IBAction func btnApplyFilter(_ sender: UIButton) {
        delegate?.filterEquipmentData()
        popViewController()
    }
}

extension MarketPlaceEquipmentFilterViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEquipmentFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterHorseTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue) as! FilterHorseTableViewCell
        filterHorseTableViewCell.selectionStyle = .none
        filterHorseTableViewCell.lblCategory.text = arrEquipmentFilter[indexPath.row].category.rawValue
        if arrEquipmentFilter[indexPath.row].category.rawValue == EquipmentFilter.location.rawValue{
            if filterEquipmentByLocation.isEmpty || filterEquipmentByLocation == "" {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                filterHorseTableViewCell.lblFilter.text = filterEquipmentByLocation
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }else if arrEquipmentFilter[indexPath.row].category.rawValue == EquipmentFilter.condition.rawValue{
            var conditionValue = [String]()
            _ = filterConditionData.compactMap({ (element) in
                if element.id != String(0){
                    conditionValue.append(element.value ?? "")
                }
            })
            let joindString = conditionValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterConditionData.count == horseFilterData?.data?.condition?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterConditionData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }
        else if arrEquipmentFilter[indexPath.row].category.rawValue == EquipmentFilter.price.rawValue{
            if filterEquipmentMinPrice == nil && filterEquipmentMaxPrice == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let priceRange = "\(filterEquipmentMinPrice!)-\(filterEquipmentMaxPrice!)"
                filterHorseTableViewCell.lblFilter.text = priceRange
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }
        filterHorseTableViewCell.indexPath = indexPath
        return filterHorseTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56 * UIScreen.main.bounds.height / 812
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        generalView.isHidden = true
        switch arrEquipmentFilter[indexPath.row].category {
        case .location:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .HorseFilterByLocationVC) as! HorseFilterByLocationViewController
            vc.mode = .equipmment
            self.navigationController?.pushViewController(vc, animated: true)
        case .condition:
            print("condition")
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .equipmment
            vc.filterEquipmentCategory = arrEquipmentFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .price:
            print("Price")
            generalView.isHidden = false
            filterEquipmentMaxPrice = nil
            filterEquipmentMinPrice = nil
            generalView.delegate = self
            let horseMinPrice = stride(from: 1000, to: 200000, by: 1000)
            arrMinPrice.append(contentsOf: horseMinPrice.map { String($0) })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByPrice.rawValue, nuberOfComponent: 2, minArray: arrMinPrice, maxArray: arrMinPrice, category: EquipmentFilter.price.rawValue)
        }
    }
}
extension MarketPlaceEquipmentFilterViewController: PassFilterArrayDelegate{
    func passArray() {
        self.tblView.reloadData()
    }
}
extension MarketPlaceEquipmentFilterViewController:MarketplaceGenralPickerViewDelegate{
    func setMinDataOfPicker(str: String, picker: UIPickerView, lastMaxPrice: String, category: String) {
        if category == EquipmentFilter.price.rawValue
        {
            filterEquipmentMinPrice = Int(str)
            if filterEquipmentMaxPrice == nil{
                filterEquipmentMaxPrice = Int(lastMaxPrice)
            }
            self.category = category
        }
    }
    func setMaxDataOfPicker(str: String, picker: UIPickerView, firstMinPrice: String, category: String) {
        if category == EquipmentFilter.price.rawValue
        {
            filterEquipmentMaxPrice = Int(str)
            if filterEquipmentMinPrice == nil{
                filterEquipmentMinPrice = Int(firstMinPrice)
            }
            self.category = category
        }
    }
}
