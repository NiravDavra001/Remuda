//
//  ContactInfoPopUPViewController.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//
protocol ContactInfoDelegate {
    func contactInfo(info: String, tag: Int)
}
import UIKit
import GooglePlaces
import IQKeyboardManagerSwift

class ContactInfoPopUPViewController: UIViewController {
    
    @IBOutlet var viewTextField: UIView!
    @IBOutlet var viewCancel: UIView!
    @IBOutlet var viewInfo: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewFirst: UIView!
    @IBOutlet var txtInfo: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var btnSave: UIButton!
    var tag: Int?
    var delegate: ContactInfoDelegate?
    private var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesClient = GMSPlacesClient.shared()
        self.setUpUI()
        self.setUpData()
        self.viewFirst.backgroundColor = .transparentColor
        let tapMainView = UITapGestureRecognizer(target: self, action:#selector(mainViewTapped))
        self.viewFirst.addGestureRecognizer(tapMainView)
    }
    @objc func mainViewTapped(){
        self.passTextFieldData()
        self.dismissViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    func setUpUI(){
        txtInfo.inputAccessoryView = UIView()
        txtInfo.autocorrectionType = .no
        txtInfo.returnKeyType = .done
        txtInfo.delegate = self
        
        self.viewTextField.setBorder(1, .horseListing_border_gray, 3)
        self.viewCancel.setBorder(0, .profile_listing_gray, 5)
        self.viewInfo.setBorder(0, .profile_listing_gray, 5)
        self.btnSave.setUpCornerRadius(5)
        self.btnCancel.setUpCornerRadius(5)
        self.lblTitle.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtInfo.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtInfo.tintColor = .app_green_color
        btnCancel.setTitleColor(.app_lblUserLocation, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        btnSave.setTitleColor(.white, for: .normal)
        btnSave.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    private func setUpData() {
        switch tag {
        case 1:
            self.lblTitle.text = "Where is this listing located?"
            self.imageView.image = UIImage(named: "location_Icon")
        case 2:
            self.lblTitle.text = "What is your contact number?"
            self.imageView.image = UIImage(named: "phone_Icon")
        case 3:
            self.lblTitle.text = "What is your contact email?"
            self.imageView.image = UIImage(named: "email_Icon")
        default:
            break
        }
    }
    
    private func passTextFieldData(){
        switch tag {
        case 1:
            delegate?.contactInfo(info: txtInfo.text ?? "", tag: self.tag ?? 0)
            self.dismiss(animated: true, completion: nil)
        case 2:
            delegate?.contactInfo(info: txtInfo.text ?? "", tag: self.tag ?? 0)
            self.dismiss(animated: true, completion: nil)
        case 3:
            delegate?.contactInfo(info: txtInfo.text ?? "", tag: self.tag ?? 0)
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    @IBAction func btnSaveAction(_ sender: UIButton) {
        self.passTextFieldData()
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ContactInfoPopUPViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch tag {
        case 1:
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            // Specify the place data types to return.
            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                        UInt(GMSPlaceField.placeID.rawValue))
            autocompleteController.placeFields = fields
            
            // Specify a filter.
            let filter = GMSAutocompleteFilter()
            filter.type = .region
            autocompleteController.autocompleteFilter = filter
            
            // Display the autocomplete view controller.
            present(autocompleteController, animated: true, completion: nil)
            
        default:
            break
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.passTextFieldData()
        return true
    }
}

extension ContactInfoPopUPViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let filter = GMSAutocompleteFilter()
        filter.type = .region
        placesClient?.findAutocompletePredictions(fromQuery: place.name ?? "" , filter: filter, sessionToken: nil, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            for result in results ?? [GMSAutocompletePrediction](){
                if let result = result as? GMSAutocompletePrediction {
                    if place.placeID == result.placeID {
                        self.txtInfo.text = (result.attributedFullText.string) as! String
                        break
                    }
                }
            }
        })
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
