//
//  UITextField+Extensions.swift
//  DilanGoDriver
//
//  Created by iMac on 08/01/21.
//

import Foundation
import UIKit

extension UITextField{
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    //MARK: Textfields done button.
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension SkyFloatingLabelTextField{
    func setSkyFloatingLabelTextField(){
        self.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.titleColor = UIColor.personalInformationTFlabel
    }
}

class CustomTextView: UITextView {
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
