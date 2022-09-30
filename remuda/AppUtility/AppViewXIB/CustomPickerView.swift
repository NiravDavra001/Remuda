//
//  CustomPickerView.swift
//  remuda
//
//  Created by Macmini on 10/06/21.
//
protocol MarketplaceGenralPickerViewDelegate {
    func setMinDataOfPicker(str : String , picker : UIPickerView , lastMaxPrice: String, category: String)
    func setMaxDataOfPicker(str : String , picker : UIPickerView , firstMinPrice: String, category: String)
}
import UIKit

class CustomPickerView: UIView {
    
    @IBOutlet var navView: UIView!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tbnDone: UIButton!
    var minDataSource = [String]()
    var maxDataSource = [String]()
    var delegate: MarketplaceGenralPickerViewDelegate?
    var tmpArray = [String]()
    var newMaxDataSource = [String]()
    var minTxtFeild : UITextField?
    var maxTxtFeild : UITextField?
    @IBOutlet var viewHeight: NSLayoutConstraint!
    var nuberOfComponent = Int()
    var category = String()
    @IBOutlet weak var pickerView: UIPickerView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupUI(){
        pickerView.delegate = self
        pickerView.dataSource = self
        lblTitle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        btnCancel.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        tbnDone.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        navView.clipsToBounds = true
        navView.layer.cornerRadius = 10
        navView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "CustomPickerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        setupUI()
    }
    func dataOfPickerView(title: String, nuberOfComponent: Int, minArray: [String], maxArray: [String], category: String){
        self.category = category
        minDataSource.removeAll()
        maxDataSource.removeAll()
        self.nuberOfComponent = nuberOfComponent
        self.lblTitle.text = title
        minDataSource.append(contentsOf: minArray.map { String($0) })
        maxDataSource.append(contentsOf: maxArray.map { String($0) })
        minDataSource.insert("No Min", at: 0)
        maxDataSource.append("No Max")
        self.reloadPickerView()
        self.tmpArray = self.maxDataSource
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView.selectRow(maxArray.count, inComponent: 1, animated: false)
    }
    func reloadPickerView(){
        pickerView.reloadAllComponents()
    }
}

extension CustomPickerView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return nuberOfComponent
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return minDataSource.count
        case 1:
            return maxDataSource.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return minDataSource[row]
        case 1:
            return maxDataSource[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var minValue = String()
        switch component {
        case 0:
            minValue = minDataSource[row]
            maxDataSource = tmpArray
            let index = maxDataSource.firstIndex { (res)  in
                res == minValue
            }
            if let indexForRemove = index{
                newMaxDataSource.removeAll()
                for i in 0..<maxDataSource.count {
                     if i >= 0 && i <= indexForRemove {
                        /// Avoid
                        continue
                     }
                    newMaxDataSource.append(maxDataSource[i])
                }
                maxDataSource = newMaxDataSource
            }
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            self.delegate?.setMinDataOfPicker(str: minDataSource[row], picker: self.pickerView, lastMaxPrice: maxDataSource[0], category: self.category)
        case 1:
            self.delegate?.setMaxDataOfPicker(str: maxDataSource[row], picker: self.pickerView, firstMinPrice: minDataSource[1], category: self.category)
        default:
            break
        }
    }
    
}
