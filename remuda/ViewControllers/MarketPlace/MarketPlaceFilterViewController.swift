//
//  MarketPlaceFilterViewController.swift
//  remuda
//
//  Created by Macmini on 08/06/21.
//
enum HorseFilter: String{
    case breed  = "Breed"
    case discipline = "Discipline"
    case price  = "Price"
    case location   = "Location"
    //    case sire   = "Sire"
    case height = "Height"
    case age    = "Age"
    case gender = "Gender"
    case color  = "Color"
    case lifeTimeEarnings = "Life Time Earnings"
//    case foalTo = "Foal To"
}
struct HorsesFilterModel {
    var category: HorseFilter
}
protocol ApplyHorseFilterDelegate {
    func filterHorseData()
}
import UIKit

class MarketPlaceFilterViewController: UIViewController {
    @IBOutlet var generalView: CustomPickerView!
    var agePicker = genralPickerView()
    @IBOutlet var btnApplyFilter: UIButton!
    @IBOutlet var tblView: UITableView!
    var arrHorseFilter = [HorsesFilterModel]()
    var arrHorseAge = [String]()
    var arrHorseHeight = [String]()
    var arrMinPrice = [String]()
    var arrMaxPrice = [String]()
    var arrLifeTimeEarning = [String]()
    var delegate: ApplyHorseFilterDelegate?
    var category = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
        self.setResetButton()
        self.tblView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnApplyFilter.setUpCornerRadius(5)
    }
    private func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .FilterHorses)
        btnApplyFilter.tintColor = .white
        btnApplyFilter.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.generalView.btnCancel.addTarget(self, action: #selector(btnPickerCancel(sender:)), for: .touchUpInside)
        self.generalView.tbnDone.addTarget(self, action: #selector(btnPickerDone(sender:)), for: .touchUpInside)
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.register(UINib(nibName: TableCellIdentifiers.FilterHorseTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue)
    }
    private func setUpData() {
        arrHorseFilter = [
            HorsesFilterModel(category: .breed),
            HorsesFilterModel(category: .discipline),
            HorsesFilterModel(category: .price),
            HorsesFilterModel(category: .location),
            //            HorsesFilterModel(category: .sire),
            HorsesFilterModel(category: .height),
            HorsesFilterModel(category: .age),
            HorsesFilterModel(category: .gender),
            HorsesFilterModel(category: .color),
            HorsesFilterModel(category: .lifeTimeEarnings),
//            HorsesFilterModel(category: .foalTo)
        ]
    }
    private func setResetButton(){
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
        filterBreedData.removeAll()
        filterDisciplineData.removeAll()
        filterColorData.removeAll()
        filterGenderData.removeAll()
        filterHorseByLocation = ""
        horseFilterData = tmpHorseFilterData
        filterMaxPrice = nil
        filterMinPrice = nil
        filterMinAge = nil
        filterMaxAge = nil
        filterMinHeight = nil
        filterMaxHeight = nil
        filterMinLTE = nil
        filterMaxLTE = nil
        self.tblView.reloadData()
    }
    
    @objc func btnPickerCancel(sender: UIButton){
        self.generalView.isHidden = true
    }
    @objc func btnPickerDone(sender: UIButton){
        if category == HorseFilter.price.rawValue
        {
            if filterMinPrice == nil && filterMaxPrice == nil{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }else{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }
        }
        else if category == HorseFilter.age.rawValue
        {
            if filterMinAge == nil && filterMaxAge == nil{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }else{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }
        }
        else if category == HorseFilter.height.rawValue
        {
            if filterMinHeight == nil && filterMaxHeight == nil{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }else{
                self.tblView.reloadData()
                self.generalView.isHidden = true
            }
        }
        else if category == HorseFilter.lifeTimeEarnings.rawValue
        {
            if filterMinLTE == nil && filterMaxLTE == nil{
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
    
    @IBAction func btnApplyFilter(_ sender: UIButton) {
        delegate?.filterHorseData()
        popViewController()
    }
    
}

extension MarketPlaceFilterViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHorseFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterHorseTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.FilterHorseTVCell.rawValue) as! FilterHorseTableViewCell
        filterHorseTableViewCell.selectionStyle = .none
        filterHorseTableViewCell.lblCategory.text = arrHorseFilter[indexPath.row].category.rawValue
        if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.breed.rawValue{
            var breedValue = [String]()
            _ = filterBreedData.compactMap({ (element) in
                if element.id != String(0){
                    breedValue.append(element.value ?? "")
                }
            })
            let joindString = breedValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterBreedData.count == horseFilterData?.data?.breed?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterBreedData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.discipline.rawValue{
            var disciplineValue = [String]()
            _ = filterDisciplineData.compactMap({ (element) in
                if element.id != String(0){
                    disciplineValue.append(element.value ?? "")
                }
            })
            let joindString = disciplineValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterDisciplineData.count == horseFilterData?.data?.discipline?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterDisciplineData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.color.rawValue{
            var colorValue = [String]()
            _ = filterColorData.compactMap({ (element) in
                if element.id != String(0){
                    colorValue.append(element.value ?? "")
                }
            })
            let joindString = colorValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterColorData.count == horseFilterData?.data?.color?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterColorData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.gender.rawValue{
            var genderValue = [String]()
            _ = filterGenderData.compactMap({ (element) in
                if element.id != String(0){
                    genderValue.append(element.value ?? "")
                }
            })
            let joindString = genderValue.joined(separator: ",")
            if joindString.isEmpty || joindString == ""{
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                if filterGenderData.count == horseFilterData?.data?.gender?.count ?? 0 {
                    filterHorseTableViewCell.lblFilter.text = filterGenderData.first?.value
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }else{
                    filterHorseTableViewCell.lblFilter.text = joindString
                    filterHorseTableViewCell.lblFilter.textColor = .app_green_color
                }
            }
        }
        else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.price.rawValue{
            if filterMinPrice == nil && filterMaxPrice == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let priceRange = "\(filterMinPrice!)-\(filterMaxPrice!)"
                filterHorseTableViewCell.lblFilter.text = priceRange
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }
        else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.age.rawValue{
            if filterMinAge == nil && filterMaxAge == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let ageRange = "\(filterMinAge!)-\(filterMaxAge!)"
                filterHorseTableViewCell.lblFilter.text = ageRange
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }
        else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.height.rawValue{
            if filterMinHeight == nil && filterMaxHeight == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let heightRange = "\(filterMinHeight ?? "5 hh")-\(filterMaxHeight ?? "21 hh")"
                filterHorseTableViewCell.lblFilter.text = heightRange
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }
        else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.location.rawValue{
            if filterHorseByLocation.isEmpty || filterHorseByLocation == "" {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                filterHorseTableViewCell.lblFilter.text = filterHorseByLocation
                filterHorseTableViewCell.lblFilter.textColor = .app_green_color
            }
        }
        else if arrHorseFilter[indexPath.row].category.rawValue == HorseFilter.lifeTimeEarnings.rawValue{
            if filterMinLTE == nil && filterMaxLTE == nil {
                filterHorseTableViewCell.lblFilter.text = "Any"
                filterHorseTableViewCell.lblFilter.textColor = .filterGrey
            }else{
                let priceRange = "\(filterMinLTE!)-\(filterMaxLTE!)"
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
        switch arrHorseFilter[indexPath.row].category {
        case .breed:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .horse
            vc.filterCategory = arrHorseFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .discipline:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .horse
            vc.filterCategory = arrHorseFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .price:
            generalView.isHidden = false
            filterMaxPrice = nil
            filterMinPrice = nil
            generalView.delegate = self
            let horseMinPrice = stride(from: 1000, to: 200000, by: 1000)
            arrMinPrice.append(contentsOf: horseMinPrice.map { String($0) })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByPrice.rawValue, nuberOfComponent: 2, minArray: arrMinPrice, maxArray: arrMinPrice, category: HorseFilter.price.rawValue)
        case .location:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .HorseFilterByLocationVC) as! HorseFilterByLocationViewController
            vc.mode = .horse
            self.navigationController?.pushViewController(vc, animated: true)
        //        case .sire:
        //            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterBySireVC) as! FilterBySireViewController
        //            vc.filterCategory = arrHorseFilter[indexPath.row].category
        //            vc.indexPath = indexPath
        //            self.navigationController?.pushViewController(vc, animated: true)
        case .height:
            generalView.isHidden = false
            filterMinHeight = nil
            filterMaxHeight = nil
            generalView.delegate = self
            let horseHeight = horseHeights
            arrHorseHeight.append(contentsOf: horseHeight.map { $0 })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByHeight.rawValue, nuberOfComponent: 2, minArray: arrHorseHeight, maxArray: arrHorseHeight, category: HorseFilter.height.rawValue)
        case .age:
            generalView.isHidden = false
            generalView.delegate = self
            let horseAge = (1...100).map { $0 * 1 }
            arrHorseAge.append(contentsOf: horseAge.map { String($0) })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByAge.rawValue, nuberOfComponent: 2, minArray: arrHorseAge, maxArray: arrHorseAge, category: HorseFilter.age.rawValue)
        case .gender:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .horse
            vc.filterCategory = arrHorseFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .color:
            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterVC) as! FilterViewController
            vc.mode = .horse
            vc.filterCategory = arrHorseFilter[indexPath.row].category
            vc.delegate = self
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case .lifeTimeEarnings:
            generalView.isHidden = false
            filterMinLTE = nil
            filterMaxLTE = nil
            generalView.delegate = self
            let horsePrice = stride(from: 100000, to: 500000, by: 5000)
            arrLifeTimeEarning.append(contentsOf: horsePrice.map { String($0) })
            generalView.dataOfPickerView(title: ViewControllerTitle.FilterByLTE.rawValue, nuberOfComponent: 2, minArray: arrLifeTimeEarning, maxArray: arrLifeTimeEarning, category: HorseFilter.lifeTimeEarnings.rawValue)
//        case .foalTo:
//            let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .FilterBySireVC) as! FilterBySireViewController
//            vc.filterCategory = arrHorseFilter[indexPath.row].category
//            vc.indexPath = indexPath
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MarketPlaceFilterViewController: PassFilterArrayDelegate{
    func passArray() {
        self.tblView.reloadData()
    }
}

extension MarketPlaceFilterViewController:MarketplaceGenralPickerViewDelegate{
    func setMinDataOfPicker(str: String, picker: UIPickerView, lastMaxPrice: String, category: String) {
        if category == HorseFilter.price.rawValue
        {
            filterMinPrice = Int(str)
            if filterMaxPrice == nil{
                filterMaxPrice = Int(lastMaxPrice)
            }
            self.category = category
        }
        else if category == HorseFilter.age.rawValue
        {
            filterMinAge = Int(str)
            if filterMaxAge == nil{
                filterMaxAge = Int(lastMaxPrice)
            }
            self.category = category
        }
        else if category == HorseFilter.height.rawValue
        {
            filterMinHeight = str
            if filterMaxHeight == nil{
                filterMaxHeight = lastMaxPrice
            }
            self.category = category
        }
        else if category == HorseFilter.lifeTimeEarnings.rawValue
        {
            filterMinLTE = Int(str)
            if filterMaxLTE == nil{
                filterMaxLTE = Int(lastMaxPrice)
            }
            self.category = category
        }
    }
    func setMaxDataOfPicker(str: String, picker: UIPickerView, firstMinPrice: String, category: String) {
        if category == HorseFilter.price.rawValue
        {
            filterMaxPrice = Int(str)
            if filterMinPrice == nil{
                filterMinPrice = Int(firstMinPrice)
            }
            self.category = category
        }
        else if category == HorseFilter.age.rawValue
        {
            filterMaxAge = Int(str)
            if filterMinAge == nil{
                filterMinAge = Int(firstMinPrice)
            }
            self.category = category
        }
        else if category == HorseFilter.height.rawValue
        {
            filterMaxHeight = str
            if filterMinHeight == nil{
                filterMinHeight  = firstMinPrice
            }
            self.category = category
        }
        else if category == HorseFilter.lifeTimeEarnings.rawValue
        {
            filterMaxLTE = Int(str)
            if filterMinLTE == nil{
                filterMinLTE = Int(firstMinPrice)
            }
            self.category = category
        }
    }
}
