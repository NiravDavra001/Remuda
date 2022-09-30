//
//  FilterViewController.swift
//  remuda
//
//  Created by Macmini on 08/06/21.
//

protocol PassFilterArrayDelegate {
    func passArray()
}
import UIKit

class FilterViewController: UIViewController {
    var mode : MarketPlaceMode?
    var filterCategory = HorseFilter(rawValue: "")
    var filterEquipmentCategory = EquipmentFilter(rawValue: "")
    var filterTackCategory = TackFilter(rawValue: "")
    @IBOutlet var tblView: UITableView!
    
    var delegate: PassFilterArrayDelegate?
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.tblView.reloadData()
    }
    
    //MARK: setUpUI function
    func setUpUI(){
        setCustomnavigationButton(targetDone: self, selectorDone: #selector(btnDoneTap(sender:)), targetCancel: self, selectorCancel: #selector(btnCancelTap(sender:)))
        
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
        tblView.register(UINib(nibName: TableCellIdentifiers.FilterCategoryTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FilterCategoryTVCell.rawValue)
        
        switch self.mode {
        case .horse:
            switch self.filterCategory {
            case .breed:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByBreed)
            case .discipline:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByDiscipline)
            case .color:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByColor)
            case .gender:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByGender)
            default:
                break
            }
        case .equipmment:
            switch self.filterEquipmentCategory {
            case .condition:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByCondition)
            default:
                break
            }
        case .tack:
            switch self.filterTackCategory {
            case .condition:
                self.setNavigationBarSubVCTitle(navTitle: .FilterByCondition)
            default:
                break
            }
        default:
            break
        }
    }
    
    //    MARK: Button Done
    @objc func btnDoneTap(sender: UIBarButtonItem) {
        delegate?.passArray()
        self.popViewController()
    }
    
    //    MARK: Button Cancel
    @objc func btnCancelTap(sender: UIBarButtonItem) {
        self.popViewController()
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.mode {
        case .horse:
            switch self.filterCategory {
            case .breed:
                return horseFilterData?.data?.breed?.count ?? 0
            case .discipline:
                return horseFilterData?.data?.discipline?.count ?? 0
            case .color:
                return horseFilterData?.data?.color?.count ?? 0
            case .gender:
                return horseFilterData?.data?.gender?.count ?? 0
            default:
                return 0
            }
        case .equipmment:
            switch self.filterEquipmentCategory {
            case .condition:
                return horseFilterData?.data?.condition?.count ?? 0
            default:
                return 0
            }
        case .tack:
            switch self.filterTackCategory {
            case .condition:
                return horseFilterData?.data?.tackCondition?.count ?? 0
            default:
                return 0
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterCategoryTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.FilterCategoryTVCell.rawValue) as! FilterCategoryTableViewCell
        filterCategoryTVCell.indexPath = indexPath
        filterCategoryTVCell.delegate = self
        
        switch self.mode {
        case .horse:
            switch self.filterCategory {
            case .breed:
                filterCategoryTVCell.cellBreed = horseFilterData?.data?.breed?[indexPath.row]
                if let isSelect = horseFilterData?.data?.breed?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            case .discipline:
                filterCategoryTVCell.cellDiscipline = horseFilterData?.data?.discipline?[indexPath.row]
                if let isSelect = horseFilterData?.data?.discipline?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            case .color:
                filterCategoryTVCell.cellColor = horseFilterData?.data?.color?[indexPath.row]
                if let isSelect = horseFilterData?.data?.color?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            case .gender:
                filterCategoryTVCell.cellGender = horseFilterData?.data?.gender?[indexPath.row]
                if let isSelect = horseFilterData?.data?.gender?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            default:
                return filterCategoryTVCell
            }
        case .equipmment:
            switch self.filterEquipmentCategory {
            case .condition:
                filterCategoryTVCell.cellCondition = horseFilterData?.data?.condition?[indexPath.row]
                if let isSelect = horseFilterData?.data?.condition?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            default:
                return filterCategoryTVCell
            }
        case .tack:
            switch self.filterTackCategory {
            case .condition:
                filterCategoryTVCell.cellTackCondition = horseFilterData?.data?.tackCondition?[indexPath.row]
                if let isSelect = horseFilterData?.data?.tackCondition?[indexPath.row].isSelected{
                    filterCategoryTVCell.btnCheck.isSelected = isSelect
                }
                return filterCategoryTVCell
            default:
                return filterCategoryTVCell
            }
        default:
            return filterCategoryTVCell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * UIScreen.main.bounds.height / 812
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectTableviewAndButton(indexPath: indexPath)
        self.tblView.reloadData()
    }
    
}

extension FilterViewController: FilterCategoryTableViewCellDelegate{
    func checkBoxButtonAction(indexPath: IndexPath) {
        self.didSelectTableviewAndButton(indexPath: indexPath)
    }
}
//MARK:- didSelectTableviewAndButton function for filter type selection.
extension FilterViewController {
    func didSelectTableviewAndButton(indexPath: IndexPath) {
        switch self.mode {
        case .horse:
            switch self.filterCategory {
            case .breed:
                
                if horseFilterData?.data?.breed?[indexPath.row].id == nil{
                    if horseFilterData?.data?.breed?[indexPath.row].isSelected == false{
                        let tempBreed = horseFilterData?.data?.breed?.compactMap({ element in
                            return Breed(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterBreedData.removeAll()
                        _ = horseFilterData?.data?.breed?.compactMap({
                            filterBreedData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.breed = tempBreed
                    }else{
                        let tempBreed = horseFilterData?.data?.breed?.compactMap({ element in
                            return Breed(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterBreedData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.breed = tempBreed
                    }
                }else{
                    if horseFilterData?.data?.breed?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.breed?[0].isSelected = false
                        horseFilterData?.data?.breed?[indexPath.row].isSelected = false
                        for data in 0...filterBreedData.count - 1{
                            if filterBreedData[data].id == String(horseFilterData?.data?.breed?[indexPath.row].id ?? 0){
                                filterBreedData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterBreedData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.breed?[indexPath.row].id ?? 0), value: horseFilterData?.data?.breed?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.breed?[indexPath.row].isSelected = true
                    }
                }
                print(filterBreedData)
                print(filterBreedData.count)
                
            case .discipline:
                if horseFilterData?.data?.discipline?[indexPath.row].id == nil{
                    if horseFilterData?.data?.discipline?[indexPath.row].isSelected == false{
                        let tempDiscipline = horseFilterData?.data?.discipline?.compactMap({ element in
                            return Discipline(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterDisciplineData.removeAll()
                        _ = horseFilterData?.data?.discipline?.compactMap({
                            filterDisciplineData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.discipline = tempDiscipline
                    }else{
                        let tempDiscipline = horseFilterData?.data?.discipline?.compactMap({ element in
                            return Discipline(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterDisciplineData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.discipline = tempDiscipline
                    }
                }else{
                    if horseFilterData?.data?.discipline?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.discipline?[0].isSelected = false
                        horseFilterData?.data?.discipline?[indexPath.row].isSelected = false
                        for data in 0...filterDisciplineData.count - 1{
                            if filterDisciplineData[data].id == String(horseFilterData?.data?.discipline?[indexPath.row].id ?? 0){
                                filterDisciplineData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterDisciplineData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.discipline?[indexPath.row].id ?? 0), value: horseFilterData?.data?.discipline?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.discipline?[indexPath.row].isSelected = true
                    }
                }
                print(filterDisciplineData)
                print(filterDisciplineData.count)
                
            case .color:
                if horseFilterData?.data?.color?[indexPath.row].id == nil{
                    if horseFilterData?.data?.color?[indexPath.row].isSelected == false{
                        let tempColor = horseFilterData?.data?.color?.compactMap({ element in
                            return Color(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterColorData.removeAll()
                        _ = horseFilterData?.data?.color?.compactMap({
                            filterColorData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.color = tempColor
                    }else{
                        let tempColor = horseFilterData?.data?.color?.compactMap({ element in
                            return Color(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterColorData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.color = tempColor
                    }
                }else{
                    if horseFilterData?.data?.color?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.color?[0].isSelected = false
                        horseFilterData?.data?.color?[indexPath.row].isSelected = false
                        for data in 0...filterColorData.count - 1{
                            if filterColorData[data].id == String(horseFilterData?.data?.color?[indexPath.row].id ?? 0){
                                filterColorData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterColorData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.color?[indexPath.row].id ?? 0), value: horseFilterData?.data?.color?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.color?[indexPath.row].isSelected = true
                    }
                }
                print(filterColorData)
                print(filterColorData.count)
            case .gender:
                if horseFilterData?.data?.gender?[indexPath.row].id == nil{
                    if horseFilterData?.data?.gender?[indexPath.row].isSelected == false{
                        let tempGender = horseFilterData?.data?.gender?.compactMap({ element in
                            return Gender(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterGenderData.removeAll()
                        _ = horseFilterData?.data?.gender?.compactMap({
                            filterGenderData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.gender = tempGender
                    }else{
                        let tempGender = horseFilterData?.data?.gender?.compactMap({ element in
                            return Gender(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterGenderData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.gender = tempGender
                    }
                }else{
                    if horseFilterData?.data?.gender?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.gender?[0].isSelected = false
                        horseFilterData?.data?.gender?[indexPath.row].isSelected = false
                        for data in 0...filterGenderData.count - 1{
                            if filterGenderData[data].id == String(horseFilterData?.data?.gender?[indexPath.row].id ?? 0){
                                filterGenderData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterGenderData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.gender?[indexPath.row].id ?? 0), value: horseFilterData?.data?.gender?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.gender?[indexPath.row].isSelected = true
                    }
                }
                print(filterGenderData)
                print(filterGenderData.count)
            default:
                break
            }
        case .equipmment:
            switch self.filterEquipmentCategory {
            case .condition:
                if horseFilterData?.data?.condition?[indexPath.row].id == nil{
                    if horseFilterData?.data?.condition?[indexPath.row].isSelected == false{
                        let tempCondition = horseFilterData?.data?.condition?.compactMap({ element in
                            return Condition(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterConditionData.removeAll()
                        _ = horseFilterData?.data?.condition?.compactMap({
                            filterConditionData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.condition = tempCondition
                    }else{
                        let tempCondition = horseFilterData?.data?.condition?.compactMap({ element in
                            return Condition(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterConditionData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.condition = tempCondition
                    }
                }else{
                    if horseFilterData?.data?.condition?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.condition?[0].isSelected = false
                        horseFilterData?.data?.condition?[indexPath.row].isSelected = false
                        for data in 0...filterConditionData.count - 1{
                            if filterConditionData[data].id == String(horseFilterData?.data?.condition?[indexPath.row].id ?? 0){
                                filterConditionData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterConditionData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.condition?[indexPath.row].id ?? 0), value: horseFilterData?.data?.condition?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.condition?[indexPath.row].isSelected = true
                    }
                }
                print(filterConditionData)
                print(filterConditionData.count)
                
            default:
                break
            }
        case .tack:
            switch self.filterTackCategory {
            case .condition:
                
                if horseFilterData?.data?.tackCondition?[indexPath.row].id == nil{
                    if horseFilterData?.data?.tackCondition?[indexPath.row].isSelected == false{
                        let tempTackCondition = horseFilterData?.data?.tackCondition?.compactMap({ element in
                            return TackCondition(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                        })
                        filterTackConditionData.removeAll()
                        _ = horseFilterData?.data?.tackCondition?.compactMap({
                            filterTackConditionData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                        })
                        self.tblView.reloadData()
                        horseFilterData?.data?.tackCondition = tempTackCondition
                    }else{
                        let tempTackCondition = horseFilterData?.data?.tackCondition?.compactMap({ element in
                            return TackCondition(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                        })
                        filterTackConditionData.removeAll()
                        self.tblView.reloadData()
                        horseFilterData?.data?.tackCondition = tempTackCondition
                    }
                }else{
                    if horseFilterData?.data?.tackCondition?[indexPath.row].isSelected == true{
                        horseFilterData?.data?.tackCondition?[0].isSelected = false
                        horseFilterData?.data?.tackCondition?[indexPath.row].isSelected = false
                        for data in 0...filterTackConditionData.count - 1{
                            if filterTackConditionData[data].id == String(horseFilterData?.data?.tackCondition?[indexPath.row].id ?? 0){
                                filterTackConditionData.remove(at: data)
                                break
                            }
                        }
                        self.tblView.reloadData()
                    }else{
                        filterTackConditionData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.tackCondition?[indexPath.row].id ?? 0), value: horseFilterData?.data?.tackCondition?[indexPath.row].value ?? ""))
                        horseFilterData?.data?.tackCondition?[indexPath.row].isSelected = true
                    }
                }
                print(filterTackConditionData)
                print(filterTackConditionData.count)
                
            default:
                break
            }
        default:
            break
        }
    }
}
