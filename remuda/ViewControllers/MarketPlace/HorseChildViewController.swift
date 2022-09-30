//
//  HorseChildViewController.swift
//  remuda
//
//  Created by Macmini on 26/07/21.
//
struct HorseParentModel {
    var horseId: Int?
    var date: Int?
    var horseName: String?
    var registrationId: String?
    var gender: Int?
    var isOpened: Bool = true
    var parent: [HorseParentModel]?
}
import UIKit

class HorseChildViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var getHorseParentDetailViewModel = NewHorseListViewModel()
    var arrGetHorseParentDetail : HorseParentDetailModel?
    var horseId = Int()
    var arrChildDetails = [HorseParentModel]()
    var arrParentDetails = [HorseParentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllHorseParentDetailAPI(horseId: self.horseId)
        self.setNavigationBarSubVCTitle(navTitle: .Pedigree)
        self.setUpTableView()
        if let window = view.window {
            fixShadowImage(inView: window)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    private func setUpTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: TableCellIdentifiers.PedigreeHorseDetailsTVCell.rawValue, bundle: nil), forCellReuseIdentifier: TableCellIdentifiers.PedigreeHorseDetailsTVCell.rawValue)
    }
    
}

extension HorseChildViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrChildDetails.count != 0{
            if arrChildDetails[section].isOpened == true{
                return (arrChildDetails[0].parent?.count ?? 0) + 1
            }else{
                return 1
            }
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PedigreeHorseDetailsTVCell.rawValue) as? PedigreeHorseDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.row == 0{
            cell.lblDate.text = String(arrChildDetails[indexPath.row].date ?? 0)
            cell.lblHorseName.text = arrChildDetails[indexPath.row].horseName
            cell.lblid.text = arrChildDetails[indexPath.row].registrationId
            if arrChildDetails[indexPath.row].gender == 2{
                cell.genderView.backgroundColor = UIColor(red: 0.908, green: 0.405, blue: 0.295, alpha: 1)
            }else{
                cell.genderView.backgroundColor = UIColor(red: 0.327, green: 0.649, blue: 0.946, alpha: 1)
            }
            cell.leadigSpace.constant = 8
            if arrChildDetails[indexPath.row].isOpened == true{
                cell.btnSelect.setImage(UIImage(named: "down-arrow"), for: .normal)
            }else{
                cell.btnSelect.setImage(UIImage(named: "right-arrow"), for: .normal)
            }
            return cell
        }else{
            if arrChildDetails[0].parent?[indexPath.row - 1].gender == 2{
                cell.genderView.backgroundColor = UIColor(red: 0.908, green: 0.405, blue: 0.295, alpha: 1)
            }else{
                cell.genderView.backgroundColor = UIColor(red: 0.327, green: 0.649, blue: 0.946, alpha: 1)
            }
            cell.btnSelect.setImage(UIImage(named: "right-arrow"), for: .normal)
            cell.leadigSpace.constant = +30
            cell.lblDate.text = String(arrChildDetails[0].parent?[indexPath.row - 1].date ?? 0)
            cell.lblHorseName.text = arrChildDetails[0].parent?[indexPath.row - 1].horseName
            cell.lblid.text = arrChildDetails[0].parent?[indexPath.row - 1].registrationId
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if arrChildDetails[indexPath.row].isOpened == true{
                arrChildDetails[indexPath.row].isOpened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                arrChildDetails[indexPath.row].isOpened  = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }else{
            print(indexPath.row - 1)
            let vc = self.loadViewController(Storyboard: .MarketPlace, ViewController: .HorseChildVC) as! HorseChildViewController
            let horseId = (arrChildDetails[0].parent?[indexPath.row - 1].horseId ?? 0)
            vc.horseId = horseId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK:- API calling.
extension HorseChildViewController {
    func getAllHorseParentDetailAPI(horseId: Int){
        self.getHorseParentDetailViewModel.horseId.removeAll()
        if horseId != 0{
            getHorseParentDetailViewModel.horseId["horseid"] = horseId
        }
        self.getHorseParentDetailViewModel.getHorseParentAPI{ (isFinished, message) in
            if isFinished
            {
                self.arrGetHorseParentDetail = self.getHorseParentDetailViewModel.getAllHorseParentDetail
                let data = self.arrGetHorseParentDetail?.data
                if self.arrGetHorseParentDetail?.data?.sires?.count != 0{
                    self.arrParentDetails.append(HorseParentModel(horseId: data?.sires?.first?.id, date: data?.sires?.first?.borndate, horseName: data?.sires?.first?.title, registrationId: data?.sires?.first?.registernumber, gender: 1, isOpened: false, parent: [HorseParentModel]()))
                }
                if self.arrGetHorseParentDetail?.data?.damn?.count != 0{
                    self.arrParentDetails.append(HorseParentModel(horseId: data?.damn?.first?.id, date: data?.damn?.first?.borndate, horseName: data?.damn?.first?.title, registrationId: data?.damn?.first?.registernumber, gender: 2, isOpened: false, parent: [HorseParentModel]()))
                }
                
                self.arrChildDetails.append(HorseParentModel(horseId: data?.id , date: data?.borndate, horseName: data?.title, registrationId: data?.registernumber, gender: 2, isOpened: false, parent: self.arrParentDetails))
                if self.arrChildDetails[0].parent?.count == 0 {
                    self.tableView.setEmptyMessage("There is data not available")
                }else{
                    self.tableView.reloadData()
                    print("success")
                }
                
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
//MARK:- Apply shadow.
extension HorseChildViewController {
    private func fixShadowImage(inView view: UIView) {
        if let imageView = view as? UIImageView {
            let size = imageView.bounds.size.height
            if size <= 1 && size > 0 &&
                imageView.subviews.count == 0,
               let components = imageView.backgroundColor?.cgColor.components, components == [1, 1, 1, 0.15]
            {
                print("Fixing shadow image")
                let forcedBackground = UIView(frame: imageView.bounds)
                forcedBackground.backgroundColor = .white
                imageView.addSubview(forcedBackground)
                forcedBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
        }
        for subview in view.subviews {
            fixShadowImage(inView: subview)
        }
    }
}
