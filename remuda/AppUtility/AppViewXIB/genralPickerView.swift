//
//  genralPickerView.swift
//  sinc
//
//  Created by mac on 15/02/21.
//

import Foundation

import UIKit

protocol genralPickerViewDelegate {
    func setIndexOfPicker(str : String , picker : UIPickerView , txtField : UITextField? , index : Int)
}

class genralPickerView: UIView {
    
    var dataSource = [String]()
    var delegate : genralPickerViewDelegate?
    var currentTxtFeild : UITextField?
    var nuberOfComponent = Int()
    
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
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "genralPickerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        setupUI()
    }
    
    func reloadPickerView(){
        pickerView.reloadAllComponents()
    }
}

extension genralPickerView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.setIndexOfPicker(str: dataSource[row],picker: self.pickerView , txtField: self.currentTxtFeild, index: row)
    }
}


