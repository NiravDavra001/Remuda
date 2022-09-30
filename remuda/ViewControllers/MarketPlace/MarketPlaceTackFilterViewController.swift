//
//  MarketPlaceTackFilterViewController.swift
//  remuda
//
//  Created by Macmini on 22/06/21.
//
enum TackFilter: String{
    case location  = "Location"
    case type = "Type"
    case condition = "Condition"
    case price  = "Price"
}
struct TackFilterModel {
    var category: TackFilter
}
protocol ApplyTackFilterDelegate {
    func filterTackData()
}
import UIKit

class MarketPlaceTackFilterViewController: UIViewController {
    @IBOutlet var generalView: CustomPickerView!
    @IBOutlet var btnApplyFilter: UIButton!
    @IBOutlet var tblView: UITableView!
    var arrTackFilter = [TackFilterModel]()
    var category = String()
    var arrMinPrice = [String]()
    var delegate: ApplyTackFilterDelegate?
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
        filterTackMinPrice = nil
        filterTackMaxPrice = nil
        filterTackByLocation = ""
        filterTackConditionData.removeAll()
        filterTackTypeSaddleData.removeAll()
        horseFilterData = tmpHorseFilterData
        self.tblView.reloadData()
    }
    func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .TackFilter)
        btnApplyFilter.tintColor = .white
        btnApplyFilter.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.generalView.btnCancel.addTarget(self, action: #selector(btnPickerCancel(sender:)), for: .touchUpInside)
        self.generalView.tbnDone.addTarget(self, action: #selector(btnPickerDone(sender:)), for: .touchUpInside)
        tblView.dataSource = self
        tblView.delegate = self
        tblView.register(UINib(nibName: TableCellIdentifiers.FilterHorseTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue)
        
        arrTackFilter = [
            TackFilterModel(category: .location),
            TackFilterModel(category: .type),
            TackFilterModel(category: .condition),
            TackFilterModel(category: .price)
        ]
    }
    @objc func btnPickerCancel(sender: UIButton){
        self.generalView.isHidden = true
    }
    @objc func btnPickerDone(sender: UIButton){
        if category == TackFilter.price.rawValue
        {
            if filterMinPrice == nil && filterMaxPrice == nil{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }else{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnApplyFilter.setUpCornerRadius(5)
    }
    @IBAction func btnApplyFilter(_ sender: UIButton) {
        delegate?.filterTackData()
        popViewController()
    }
}

extension MarketPlaceTackFilterViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTackFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterHorseTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue) as! FilterHorseTableViewCell
        filterHorseTableViewCell.selectionStyle = .none
        filterHorseTableViewCell.lblCategory.text = arrTackFilter[indexPath.row].category.rawValue
        if arrTackFilter[indexPath.row].category.rawValue == TackFilter.location.rawValue{
            if filterTackByLocation.isEmpty || filterTackByLocation == "" {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                filterHorseTableViewCell.lblFilter.text = filterTackByLocation
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }else if arrTackFilter[indexPath.row].category.rawValue == TackFilter.type.rawValue{
            var tackSaddlesTypeValue = [String]()
            _ = filterTackTypeSaddleData.compactMap({ (element) in
                if element.id != String(1001) &&  element.id != String(1002){
                    tackSaddlesTypeValue.append(element.value ?? "")
                }
            })
            let joindString = tackSaddlesTypeValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterTackTypeSaddleData.count == (horseFilterData?.data?.saddle?.count ?? 0) + (horseFilterData?.data?.type?.count ?? 0) {
                    filterHorseTableViewCell.lblFilter.text = filterTackTypeSaddleData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }
        else if arrTackFilter[indexPath.row].category.rawValue == TackFilter.condition.rawValue
        {
            var tackConditionValue = [String]()
            _ = filterTackConditionData.compactMap({ (element) in
                if element.id != String(0){
                    tackConditionValue.append(element.value ?? "")
                }
            })
            let joindString = tackConditionValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterTackConditionData.count == horseFilterData?.data?.tackCondition?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterTackConditionData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }
        else if arrTackFilter[indexPath.row].category.rawValue == TackFilter.price.rawValue{
            if filterTackMinPrice == nil && filterTackMaxPrice == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let priceRange = "\(filterTackMinPrice!)-\(filterTackMaxPrice!)"
                filterHorseTableViewCell.lblFilter.text = priceRange
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }else if arrTackFilter[indexPath.row].category.rawValue == TackFilter.location.rawValue{
            if filterTackByLocation.isEmpty || filterTackByLocation == "" {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                filterHorseTableViewCell.lblFilter.text = filterTackByLocation
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
        switch arrTackFilter[indexPath.row].category {
        case .location:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .HorseFilterByLocationVC) as! HorseFilterByLocationViewController
            vc.mode = .tack
            self.navigationController?.pushViewController(vc, animated: true)
        case .type:
            print("Type")
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .TackTypeFilterVC) as! TackTypeFilterViewController
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .condition:
            print("condition")
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .tack
            vc.filterTackCategory = arrTackFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .price:
            print("Price")
            generalView.isHidden = false
            filterTackMaxPrice = nil
            filterTackMinPrice = nil
            generalView.delegate = self
            let horseMinPrice = stride(from: 1000, to: 200000, by: 1000)
            arrMinPrice.append(contentsOf: horseMinPrice.map { String($0) })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByPrice.rawValue, nuberOfComponent: 2, minArray: arrMinPrice, maxArray: arrMinPrice, category: TackFilter.price.rawValue)
        }
    }
}
extension MarketPlaceTackFilterViewController: PassFilterArrayDelegate{
    func passArray() {
        self.tblView.reloadData()
    }
}
extension MarketPlaceTackFilterViewController:MarketplaceGenralPickerViewDelegate{
    func setMinDataOfPicker(str: String, picker: UIPickerView, lastMaxPrice: String, category: String) {
        if category == TackFilter.price.rawValue
        {
            filterTackMinPrice = Int(str)
            if filterTackMaxPrice == nil{
                filterTackMaxPrice = Int(lastMaxPrice)
            }
            self.category = category
        }
    }
    func setMaxDataOfPicker(str: String, picker: UIPickerView, firstMinPrice: String, category: String) {
        if category == TackFilter.price.rawValue
        {
            filterTackMaxPrice = Int(str)
            if filterTackMinPrice == nil{
                filterTackMinPrice = Int(firstMinPrice)
            }
            self.category = category
        }
    }
}
