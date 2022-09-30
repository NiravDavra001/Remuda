//
//  FillHorseDetailViewController.swift
//  remuda
//
//  Created by Macmini on 26/07/21.
//
protocol CreatePedigreeTableviewReloadDelegate {
    func reloadTableView()
}
struct PedigreeHorseChild {
    var horseId: Int?
    var patentId: [PedigreeHorseParent]?
}
struct PedigreeHorseParent {
    var sireId: Int?
    var dimId: Int?
}
import UIKit

class FillHorseDetailViewController: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var horseNameView: UIView!
    @IBOutlet var txtHorseName: UITextField!
    @IBOutlet var horseBornDateView: UIView!
    @IBOutlet var txtHorseBornDate: UITextField!
    @IBOutlet var horseIDView: UIView!
    @IBOutlet var txtHorseID: UITextField!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewFirst: UIView!
    @IBOutlet var btnView: UIView!
    @IBOutlet var detailView: UIView!
    var delegate: CreatePedigreeTableviewReloadDelegate?
    var mode : MarketPlaceMode?
    let horseUploadViewModel = NewHorseListViewModel()
    var equipmentUploadViewModel = NewEquipmentListViewModel()
    var tackUploadViewModel = NewTackListViewModel()
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.viewFirst.backgroundColor = .transparentColor
        self.btnView.backgroundColor = .clear
        self.setUpUI()
    }
    private func setUpUI() {
        self.horseNameView.setBorder(1, .personalInformationBorder, 3)
        self.horseBornDateView.setBorder(1, .personalInformationBorder, 3)
        self.horseIDView.setBorder(1, .personalInformationBorder, 3)
        self.detailView.setUpCornerRadius(5)
        self.btnSave.setUpCornerRadius(5)
        self.btnCancel.setUpCornerRadius(5)
        self.txtHorseBornDate.delegate = self
        self.txtHorseName.delegate = self
        self.txtHorseID.delegate = self
        self.txtHorseBornDate.returnKeyType = .next
        self.txtHorseName.returnKeyType = .next
        self.txtHorseID.returnKeyType = .done
        self.lblTitle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        self.txtHorseBornDate.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtHorseName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtHorseID.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        btnCancel.setTitleColor(.app_lblUserLocation, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnSave.setTitleColor(.white, for: .normal)
        btnSave.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if txtHorseName.text == "" || txtHorseName == nil {
            self.showAlert(message: getLocalizedString(key: .enterTitle))
            return
        }
        else if txtHorseBornDate.text == "" || txtHorseBornDate == nil {
            self.showAlert(message: getLocalizedString(key: .enterBorndate))
            return
        }else if txtHorseID.text == "" || txtHorseID == nil {
            self.showAlert(message: getLocalizedString(key: .enterRegistrationNumber))
            return
        }else {
            switch self.indexPath.row {
            case 0:
                self.fillData(siredamn: 2,childids: 0,is_child: 1)
            case 1:
                self.fillData(siredamn: 1,childids: horseChildId ?? 0,is_child: 0)
            case 2:
                self.fillData(siredamn: 2, childids: horseChildId ?? 0,is_child: 0)
            default:
                break
            }
        }
    }
    private func fillData(siredamn: Int, childids: Int,is_child: Int) {
        horseUploadViewModel.dict.removeAll()
        horseUploadViewModel.dict["title"] = txtHorseName.text
        horseUploadViewModel.dict["borndate"] = txtHorseBornDate.text
        horseUploadViewModel.dict["registernumber"] = txtHorseID.text
        horseUploadViewModel.dict["siredamn"] = siredamn
        horseUploadViewModel.dict["childids"] = "\(childids),"
        horseUploadViewModel.dict["is_child"] = is_child
        horseUploadCallAPI()
    }
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FillHorseDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.txtHorseName:
            self.txtHorseBornDate.becomeFirstResponder()
        case self.txtHorseBornDate:
            self.txtHorseID.becomeFirstResponder()
        default:
            self.txtHorseID.resignFirstResponder()
        }
    }
}
//MARK:- APIs
extension FillHorseDetailViewController {
    func horseUploadCallAPI(){
        showActivityIndicator(uiView: self.view)
        horseUploadViewModel.addHorseListAPI { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                switch self.indexPath.row {
                case 0:
                    horseChildId = Int(message)
                    mainHorseChildId = Int(message)
                    horseChildIds.append(Int(message) ?? 0)
                default:
                    break
                }
                self.dismissViewController()
                self.delegate?.reloadTableView()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}
