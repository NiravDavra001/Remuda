//
//  CreatePedigreeViewController.swift
//  remuda
//
//  Created by Macmini on 26/07/21.
//

import UIKit

class CreatePedigreeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let filterHorseViewModel = HorseFilterViewModel()
    var filterHorseArrDetails : HorseFilterModel?
    var getHorseParentDetailViewModel = NewHorseListViewModel()
    var arrGetHorseParentDetail : HorseParentDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.getAllHorseParentDetailAPI(horseId: horseChildId ?? 0)
        self.setNavigationBarSubVCTitle(navTitle: .Pedigree)
    }
    private func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: TableCellIdentifiers.CreatePadigreeMapTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.CreatePadigreeMapTVCell.rawValue)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            if horseChildIds.count != 0{
                horseChildIds.removeLast()
                horseChildId = horseChildIds.last
            }else{
                horseChildId = mainHorseChildId
            }
        }
    }
}

//MARK: UITableView datasourse and delegate methods.
extension CreatePedigreeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if horseChildId == nil || horseChildId == 0{
            return 1
        }else{
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.CreatePadigreeMapTVCell.rawValue) as? CreatePadigreeMapTableViewCell else {
            return UITableViewCell()
        }
        cell.indexPath = indexPath
        cell.delegate = self
        
        if horseChildId == nil || horseChildId == 0{
            return cell
        }else{
            if indexPath.row == 0 {
                cell.detailStackView.isHidden = false
                cell.btnNewHorse.isHidden = true
                cell.lblHorseName.text = arrGetHorseParentDetail?.data?.title
                cell.lblBornDate.text = String(arrGetHorseParentDetail?.data?.borndate ?? 0)
                cell.lblRegistrationId.text = arrGetHorseParentDetail?.data?.registernumber
                return cell
            }else if indexPath.row == 1{
                let data = arrGetHorseParentDetail?.data?.sires
                if data?.count != 0{
                    cell.aboveColorView.backgroundColor = .blue
                    cell.btnNewHorse.isHidden = true
                    cell.detailStackView.isHidden = false
                    cell.lblHorseName.text = data?.first?.title
                    cell.lblBornDate.text = String(data?.first?.borndate ?? 0)
                    cell.lblRegistrationId.text = data?.first?.registernumber
                    return cell
                }else{
                    cell.aboveColorView.backgroundColor = .blue
                    cell.btnNewHorse.isHidden = false
                    cell.detailStackView.isHidden = true
                    return cell
                }
                
            }else {
                let data = arrGetHorseParentDetail?.data?.damn
                if data?.count != 0{
                    cell.aboveColorView.backgroundColor = .red
                    cell.btnNewHorse.isHidden = true
                    cell.detailStackView.isHidden = false
                    cell.lblHorseName.text = data?.first?.title
                    cell.lblBornDate.text = String(data?.first?.borndate ?? 0)
                    cell.lblRegistrationId.text = data?.first?.registernumber
                    return cell
                }else{
                    cell.btnNewHorse.isHidden = false
                    cell.detailStackView.isHidden = true
                    return cell
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let data = arrGetHorseParentDetail?.data?.sires
            if data?.count != 0{
                horseChildId = arrGetHorseParentDetail?.data?.sires?.first?.id
                horseChildIds.append(arrGetHorseParentDetail?.data?.sires?.first?.id ?? 0)
                self.pushViewController(controllerID: .CreatePedigreeVC, storyBoardID: .NewListing)
            }
        }else if indexPath.row == 2{
            let data = arrGetHorseParentDetail?.data?.damn
            if data?.count != 0{
                horseChildId = arrGetHorseParentDetail?.data?.damn?.first?.id
                horseChildIds.append(arrGetHorseParentDetail?.data?.damn?.first?.id ?? 0)
                self.pushViewController(controllerID: .CreatePedigreeVC, storyBoardID: .NewListing)
            }
            
        }
    }
}

//MARK:- TableView button action deleagate.
extension CreatePedigreeViewController: AddNewHorseDelegate {
    func addNewHorseAction(indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: ViewControllerIdentifiers.FillHorseDetailVC.rawValue) as! FillHorseDetailViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true) {
            switch indexPath.row {
            case 0:
                vc.lblTitle.text = "Horse"
                vc.indexPath = indexPath
            case 1:
                vc.lblTitle.text = "Sire - Parent"
                vc.indexPath = indexPath
            case 2:
                vc.lblTitle.text = "Dam - Parent"
                vc.indexPath = indexPath
            default:
                break
            }
        }
    }
}

//MARK:- API calling.
extension CreatePedigreeViewController {
    func getAllHorseParentDetailAPI(horseId: Int){
        self.getHorseParentDetailViewModel.horseId.removeAll()
        if horseId != 0{
            getHorseParentDetailViewModel.horseId["horseid"] = horseId
        }
        self.getHorseParentDetailViewModel.getHorseParentAPI{ (isFinished, message) in
            if isFinished
            {
                self.arrGetHorseParentDetail = self.getHorseParentDetailViewModel.getAllHorseParentDetail
                self.tableView.reloadData()
                print("success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension CreatePedigreeViewController: CreatePedigreeTableviewReloadDelegate {
    func reloadTableView() {
        self.getAllHorseParentDetailAPI(horseId: horseChildId ?? 0)
    }
}

