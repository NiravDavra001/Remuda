//
//  TackTypeFilterViewController.swift
//  remuda
//
//  Created by Macmini on 24/06/21.
//

import UIKit

class TackTypeFilterViewController: UIViewController{
    //MARK: outlets
    @IBOutlet var tblView: UITableView!
    //MARK: variables
    var delegate: PassFilterArrayDelegate?
    var indexPath = IndexPath()
    //MARK: viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpTableview()
    }
    //MARK: viewWillAppear method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.tblView.reloadData()
    }
    //MARK: setUpUI function
    func setUpUI(){
        setCustomnavigationButton(targetDone: self, selectorDone: #selector(btnDoneTap(sender:)), targetCancel: self, selectorCancel: #selector(btnCancelTap(sender:)))
        self.setNavigationBarSubVCTitle(navTitle: .FilterByType)
    }
    //MARK: setUp Tableview Function
    func setUpTableview(){
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
        tblView.register(UINib(nibName: TableCellIdentifiers.FilterCategoryTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.FilterCategoryTVCell.rawValue)
    }
    //MARK: Button Done
    @objc func btnDoneTap(sender: UIBarButtonItem) {
        delegate?.passArray()
        self.popViewController()
    }
    //MARK: Button Cancel
    @objc func btnCancelTap(sender: UIBarButtonItem) {
        self.popViewController()
    }
}

extension TackTypeFilterViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return horseFilterData?.data?.saddle?.count ?? 0
        case 1:
            return horseFilterData?.data?.type?.count ?? 0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterCategoryTVCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.FilterCategoryTVCell.rawValue) as! FilterCategoryTableViewCell
        filterCategoryTVCell.delegate = self
        filterCategoryTVCell.indexPath = indexPath
        switch indexPath.section {
        case 0:
            
            if indexPath.row > 1{
                filterCategoryTVCell.leadingConstarint.constant = +30 
            }
            filterCategoryTVCell.cellTackSaddles = horseFilterData?.data?.saddle?[indexPath.row]
            var count = 0
            _ = horseFilterData?.data?.saddle?.compactMap({
                if $0.id != 1001 && $0.id != 1002{
                    if $0.isSelected == true{
                        count += 1
                    }
                }
            })
            if count >= 1{
                horseFilterData?.data?.saddle?[1].isSelected = true
            }else{
                horseFilterData?.data?.saddle?[1].isSelected = false
            }
            if let isSaddleSelect = horseFilterData?.data?.saddle?[indexPath.row].isSelected{
                if indexPath.row == 1{
                    filterCategoryTVCell.btnCheck.isSelected = isSaddleSelect
                    filterCategoryTVCell.btnCheck.setImage(UIImage(named: "ic_selected_dash"), for: .selected)
                    
                }else{
                    filterCategoryTVCell.btnCheck.isSelected = isSaddleSelect
                }
            }
            
            if horseFilterData?.data?.saddle?[indexPath.row].id == 1002{
                filterCategoryTVCell.btnCheck.isUserInteractionEnabled = false
            }
            return filterCategoryTVCell
        case 1:
            filterCategoryTVCell.cellTackType = horseFilterData?.data?.type?[indexPath.row]
            if let isSelect = horseFilterData?.data?.type?[indexPath.row].isSelected{
                filterCategoryTVCell.btnCheck.isSelected = isSelect
            }
            return filterCategoryTVCell
        default:
            return filterCategoryTVCell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * UIScreen.main.bounds.height / 812
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableviewAndButton(indexPath: indexPath)
    }
}

extension TackTypeFilterViewController: FilterCategoryTableViewCellDelegate {
    func checkBoxButtonAction(indexPath: IndexPath) {
        didSelectTableviewAndButton(indexPath: indexPath)
    } 
}
//MARK:- didSelectTableviewAndButton function for filter type selection.
extension TackTypeFilterViewController {
    private func didSelectTableviewAndButton(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print(indexPath.row)
            if horseFilterData?.data?.saddle?[indexPath.row].id == 1001{
                if horseFilterData?.data?.saddle?[indexPath.row].isSelected == false{
                    let tempTackSaddle = horseFilterData?.data?.saddle?.compactMap({ element in
                        return Saddle(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                    })
                    let tempTackType = horseFilterData?.data?.type?.compactMap({ element in
                        return Type(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: true)
                    })
                    horseFilterData?.data?.saddle = tempTackSaddle
                    horseFilterData?.data?.type = tempTackType
                    filterTackTypeSaddleData.removeAll()
                    _ = horseFilterData?.data?.saddle?.compactMap({
                        filterTackTypeSaddleData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                    })
                    _ = horseFilterData?.data?.type?.compactMap({
                        filterTackTypeSaddleData.append(CategoryDataIDValue(id: String($0.id ?? 0), value: $0.value ?? ""))
                    })
                    self.tblView.reloadData()
                    
                }
                else{
                    let tempTackSaddle = horseFilterData?.data?.saddle?.compactMap({ element in
                        return Saddle(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false, isSaddle: false)
                    })
                    let tempTackType = horseFilterData?.data?.type?.compactMap({ element in
                        return Type(categoryId: element.categoryId, id: element.id, value: element.value, isSelected: false)
                    })
                    horseFilterData?.data?.saddle = tempTackSaddle
                    horseFilterData?.data?.type = tempTackType
                    filterTackTypeSaddleData.removeAll()
                    self.tblView.reloadData()
                }
            }
            else{
                if horseFilterData?.data?.saddle?[indexPath.row].isSelected == true{
                    horseFilterData?.data?.saddle?[0].isSelected = false
                    horseFilterData?.data?.saddle?[indexPath.row].isSelected = false
                    for data in 0...filterTackTypeSaddleData.count - 1{
                        if filterTackTypeSaddleData[data].id == String(horseFilterData?.data?.saddle?[indexPath.row].id ?? 0){
                            filterTackTypeSaddleData.remove(at: data)
                            break
                        }
                    }
                    self.tblView.reloadData()
                }
                else{
                    filterTackTypeSaddleData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.saddle?[indexPath.row].id ?? 0), value: horseFilterData?.data?.saddle?[indexPath.row].value ?? ""))
                    horseFilterData?.data?.saddle?[indexPath.row].isSelected = true
                    self.tblView.reloadData()
                }
            }
            print(filterTackTypeSaddleData)
            print(filterTackTypeSaddleData.count)
            
        case 1:
            print(indexPath.row)
            if horseFilterData?.data?.type?[indexPath.row].isSelected == true{
                horseFilterData?.data?.type?[indexPath.row].isSelected = false
                for data in 0...filterTackTypeSaddleData.count - 1{
                    if filterTackTypeSaddleData[data].id == String(horseFilterData?.data?.type?[indexPath.row].id ?? 0){
                        filterTackTypeSaddleData.remove(at: data)
                        break
                    }
                }
                self.tblView.reloadData()
            }else{
                filterTackTypeSaddleData.append(CategoryDataIDValue(id: String(horseFilterData?.data?.type?[indexPath.row].id ?? 0), value: horseFilterData?.data?.type?[indexPath.row].value ?? ""))
                horseFilterData?.data?.type?[indexPath.row].isSelected = true
            }
            print(filterTackTypeSaddleData)
            print(filterTackTypeSaddleData.count)
        default:
            break
        }
        
    }
}
