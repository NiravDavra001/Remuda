//
//  NewTackListingViewController.swift
//  remuda
//
//  Created by Macmini on 03/05/21.
//

enum TackTextFieldType {
    case type
    case saddles
    case condition
    case none
}
struct AddTackDetails {
    var title : String?
    var price : String?
    var description : String?
    var tackType : String?
    var tackSaddles : String?
    var tackCondition : String?
    var media: String?
    var email: String?
    var location: String?
    var mobile: String?
    var thumbnail: String?
    var premium: Int?
}

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class NewTackListingViewController: UIViewController {
    @IBOutlet var collectionVIewPhotoVideo: UICollectionView!
    @IBOutlet var viewForAddphotoVideo: UIView!
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var viewPrice: UIView!
    @IBOutlet var viewDescription: UIView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var txtTitle: SkyFloatingLabelTextField!
    @IBOutlet var txtPrice: SkyFloatingLabelTextField!
    @IBOutlet var txtViewDescription: UITextView!
    @IBOutlet var txtType: CustomTextField!
    @IBOutlet var txtSaddles: CustomTextField!
    @IBOutlet var txtCondition: CustomTextField!
    @IBOutlet var lblPhotoChoose: UILabel!
    @IBOutlet var lblPhotoCount: UILabel!
    @IBOutlet var lblDetails: UILabel!
    var getPlanId: Int?
    var arrCount: Int?
    var viewModel = NewTackListViewModel()
    var arrSaddle = [Saddle]()
    var arrCondition = [TackCondition]()
    var arrType = [Type]()
    var saddleId = String()
    var conditionId = String()
    var typeId = String()
    var myPickerView = UIPickerView()
    var imgArray = [ImageModel?]()
    var mediaData = [String]()
    var mediaThumbnail = String()
    var placeholderLabel : UILabel!
    var selectedTypeId = 0
    var selectedSaddleId = 0
    var selectedConditionId = 0
    var selectedPikerType =  TackTextFieldType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpData()
        self.setPlaceholderForTextView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.setUpCornerRadius(5)
        viewTitle.setBorder(1, .horseListing_border_gray, 3)
        viewPrice.setBorder(1, .horseListing_border_gray, 3)
        viewDescription.setBorder(1, .horseListing_border_gray, 3)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    private func setPlaceholderForTextView() {
        txtViewDescription.delegate = self
        txtViewDescription.tintColor = .app_green_color
        placeholderLabel = UILabel()
        placeholderLabel.text = "Description"
        placeholderLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        placeholderLabel.sizeToFit()
        txtViewDescription.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtViewDescription.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
    }
    private func setUpUI(){
        myPickerView.dataSource = self
        myPickerView.delegate = self
        txtType.txtCustomField.delegate = self
        txtSaddles.txtCustomField.delegate = self
        txtCondition.txtCustomField.delegate = self
        txtType.txtCustomField.inputView = myPickerView
        txtSaddles.txtCustomField.inputView = myPickerView
        txtCondition.txtCustomField.inputView = myPickerView
        collectionVIewPhotoVideo.dataSource = self
        collectionVIewPhotoVideo.delegate = self
        collectionVIewPhotoVideo.register(UINib(nibName: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue)
        collectionVIewPhotoVideo.register(UINib(nibName: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue)
        self.setNavigationBarSubVCTitle(navTitle: .YourTackListing)
        collectionVIewPhotoVideo.isPagingEnabled = true
        btnNext.backgroundColor = .app_green_color
        btnNext.titleLabel?.tintColor = .white
        btnNext.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtTitle.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtTitle.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtTitle.titleColor = UIColor.personalInformationTFlabel
        self.txtTitle.selectedTitleColor = .app_green_color
        self.txtTitle.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtTitle.tintColor = .app_green_color
        self.txtPrice.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtPrice.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtPrice.titleColor = UIColor.personalInformationTFlabel
        self.txtPrice.selectedTitleColor = .app_green_color
        self.txtPrice.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtPrice.tintColor = .app_green_color
        self.lblPhotoChoose.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblPhotoChoose.textColor = .app_lblUserLocation
        self.lblPhotoCount.textColor = .app_lblUserLocation
        self.lblPhotoCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblDetails.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtType.txtCustomField.placeholder = "Type"
        self.txtSaddles.txtCustomField.placeholder = "Saddles"
        self.txtCondition.txtCustomField.placeholder = "Condition"
    }
    private func setUpData(){
        if getPlanId == 2{
            self.lblPhotoChoose.text = "You may choose up to 4 photos"
            self.lblPhotoCount.text = "0/4 Photos"
        }else{
            self.lblPhotoChoose.text = "You may choose up to 8 photos"
            self.lblPhotoCount.text = "0/8 Photos"
        }
        
        let categoryDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: HorseCategoryModel.self, key: .storeAllHorseCategory)
        self.arrSaddle.removeAll()
        self.arrCondition.removeAll()
        self.arrType.removeAll()
        self.arrSaddle = categoryDetails?.data?.saddle ?? []
        self.arrSaddle.removeFirst()
        self.arrSaddle.removeFirst()
        self.arrCondition = categoryDetails?.data?.tackCondition ?? []
        self.arrCondition.removeFirst()
        self.arrType = categoryDetails?.data?.type ?? []
    }
    @IBAction func btnNext(_ sender: UIButton) {
        mediaData.removeAll()
        
        if imgArray.isEmpty {
            self.showAlert(message: "Please select image")
            return
        }
        else if txtTitle.text == "" || txtTitle == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackTitle))
            return
        }
        else if txtPrice.text == "" || txtPrice == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackPrice))
            return
        }else if txtViewDescription.text == "" || txtViewDescription == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackDescription))
            return
        }else if txtType.txtCustomField.text == "" || txtType.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackType))
            return
        }else if txtSaddles.txtCustomField.text == "" || txtSaddles.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackSaddles))
            return
        }else if txtCondition.txtCustomField.text == "" || txtCondition.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterTackCondition))
            return
        }
        
        addTackDetails.price = txtPrice.text
        addTackDetails.title = txtTitle.text
        addTackDetails.description = txtViewDescription.text
        addTackDetails.tackType = typeId
        addTackDetails.tackSaddles = saddleId
        addTackDetails.tackCondition = conditionId
        addTackDetails.premium = self.getPlanId
        let vc = self.loadViewController(Storyboard: .NewListing, ViewController: .ContactInfoVC) as! ContactInfoViewController
        vc.mode = .tack
        vc.imgArray = self.imgArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewTackListingViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imgArray.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let horseListingPhotosCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue, for: indexPath) as? NewListingPhotosCollectionViewCell
        let photoVideoSelectionCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue, for: indexPath) as? PhotoVideoSelectionCollectionViewCell
        if indexPath.row == imgArray.count{
            photoVideoSelectionCVCell?.delegate = self
            return photoVideoSelectionCVCell ?? UICollectionViewCell()
        }else{
            horseListingPhotosCVCell?.indexPath = indexPath
            horseListingPhotosCVCell?.imgHorseListing.image = imgArray[indexPath.row]?.image
            horseListingPhotosCVCell?.btnRemove.tag = indexPath.row
            horseListingPhotosCVCell?.btnRemove.addTarget(self, action: #selector(removeImage(sender:)), for: .touchUpInside)
            return horseListingPhotosCVCell ?? UICollectionViewCell()
        }
    }
    @objc func removeImage(sender:UIButton) {
        let i : Int = sender.tag
        imgArray.remove(at: i)
        collectionVIewPhotoVideo.reloadData()
        if getPlanId == 2{
            var count = 0
            _ = imgArray.compactMap({ if $0?.videoUrl == nil{ count += 1 } })
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                self.lblPhotoCount.text = String("\(count)" + "/4 Photos")
            })
        }else{
            var count = 0
            _ = imgArray.compactMap({ if $0?.videoUrl == nil{ count += 1 } })
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                self.lblPhotoCount.text = String("\(count)" + "/8 Photos")
            })
        }
    }
    //MARK: collectionview height width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if imgArray.count == 0 {
            return CGSize(width: self.collectionVIewPhotoVideo.bounds.width, height: self.collectionVIewPhotoVideo.bounds.height)
        }else{
            return CGSize(width: (self.collectionVIewPhotoVideo.bounds.width - 8) / 2.2, height: self.collectionVIewPhotoVideo.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension NewTackListingViewController: ListingPhotoSelectionDelegate{
    
    func btnAddPhotoVideoTapped() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                self.showAlert(message: "Camera is not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.allowsEditing = true
            imagePickerController.isEditing = true
            if self.getPlanId == 2{
                imagePickerController.videoMaximumDuration = 15.00
            }else{
                //TODO:- 180.00 seconds for premium plan
                imagePickerController.videoMaximumDuration = 45.00
            }
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension NewTackListingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
            if getPlanId == 2{
                var count = 0
                _ = imgArray.compactMap({ if $0?.videoUrl == nil{ count += 1 } })
                if count < 4{
                    imgArray.append(ImageModel(id: imgArray.count, image: image, videoUrl: nil))
                    arrCount = imgArray.count
                    print("Append id is:",imgArray.count)
                    lblPhotoCount.text = String("\(count + 1)" + "/4 Photos")
                    collectionVIewPhotoVideo.reloadData()
                    picker.dismiss(animated: true, completion: nil)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                        picker.dismiss(animated: true, completion: nil)
                        self.showAlert(message: "Please enter less than 4 photos")
                    })
                }
            }else{
                var count = 0
                _ = imgArray.compactMap({ if $0?.videoUrl == nil{ count += 1 } })
                if count < 9{
                    imgArray.append(ImageModel(id: imgArray.count, image: image, videoUrl: nil))
                    arrCount = imgArray.count
                    lblPhotoCount.text = String("\(count + 1)" + "/8 Photos")
                    collectionVIewPhotoVideo.reloadData()
                    picker.dismiss(animated: true, completion: nil)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                        picker.dismiss(animated: true, completion: nil)
                        self.showAlert(message: "Please enter less than 8 photos")
                    })
                    
                }
            }
        }
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String{
            if CFStringCompare(mediaType as CFString?, kUTTypeMovie, []) == .compareEqualTo {
                let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                if let movieName = videoUrl?.absoluteURL{
                    print("movieName = \(movieName)")
                    if getPlanId == 2{
                        if imgArray.count < 5{
                            var count = 0
                            _ = imgArray.compactMap({ if $0?.videoUrl != nil{ count += 1 } })
                            if count == 0{
                                let image = createThumbnailOfVideoFromRemoteUrl(url: movieName.absoluteString){
                                    self.showAlert(message: "An unexpected error occurred while uploading your image, please try again later")
                                }
                                imgArray.append(ImageModel(id: imgArray.count, image: image, videoUrl: movieName))
                                arrCount = imgArray.count
                                print("Append id is:",imgArray.count)
                                collectionVIewPhotoVideo.reloadData()
                                picker.dismiss(animated: true, completion: nil)
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                                    picker.dismiss(animated: true, completion: nil)
                                    self.showAlert(message: "Please select less than 1 video")
                                })
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                                picker.dismiss(animated: true, completion: nil)
                                self.showAlert(message: "Please select less than 1 video")
                            })
                        }
                    }else{
                        if imgArray.count < 9{
                            var count = 0
                            _ = imgArray.compactMap({ if $0?.videoUrl != nil{ count += 1 } })
                            if count == 0{
                                let image = createThumbnailOfVideoFromRemoteUrl(url: movieName.absoluteString){
                                    self.showAlert(message: "An unexpected error occurred while uploading your image, please try again later")
                                }
                                imgArray.append(ImageModel(id: imgArray.count, image: image, videoUrl: movieName))
                                arrCount = imgArray.count
                                print("Append id is:",imgArray.count)
                                collectionVIewPhotoVideo.reloadData()
                                picker.dismiss(animated: true, completion: nil)
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                                    picker.dismiss(animated: true, completion: nil)
                                    self.showAlert(message: "Please select less than 1 video")
                                })
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1), execute: {
                                picker.dismiss(animated: true, completion: nil)
                                self.showAlert(message: "Please select less than 1 video")
                            })
                        }
                    }
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension NewTackListingViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedPikerType {
        case .type      : return arrType.count
        case .saddles   : return arrSaddle.count
        case .condition : return arrCondition.count
        case .none      : return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedPikerType {
        case .type      : return arrType[row].value
        case .saddles   : return arrSaddle[row].value
        case .condition : return arrCondition[row].value
        case .none      : return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedPikerType {
        case .type           :
            txtType.txtCustomField.text = arrType[row].value
            typeId = String(arrType[row].id ?? 0)
            self.selectedTypeId = row
        case .saddles          :
            txtSaddles.txtCustomField.text = arrSaddle[row].value
            saddleId = String(arrSaddle[row].id ?? 0)
            self.selectedSaddleId = row
        case .condition             :
            txtCondition.txtCustomField.text = arrCondition[row].value
            conditionId = String(arrCondition[row].id ?? 0)
            self.selectedConditionId = row
        case .none            : break
        }
    }
}

extension NewTackListingViewController: UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case txtType.txtCustomField      : selectedPikerType    = .type
        case txtSaddles.txtCustomField   : selectedPikerType    = .saddles
        case txtCondition.txtCustomField : selectedPikerType    = .condition
        default                          : selectedPikerType    = .none
        }
        self.myPickerView.reloadAllComponents()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.switchBasedNextTextField(textField)
        }
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        
        switch selectedPikerType {
        case .type           :
            self.myPickerView.selectRow(self.selectedTypeId, inComponent: 0, animated: true)
            txtType.txtCustomField.text = arrType[self.selectedTypeId].value
            typeId = String(arrType[self.selectedTypeId].id ?? 0)
        case .saddles:
            self.myPickerView.selectRow(self.selectedSaddleId, inComponent: 0, animated: true)
            txtSaddles.txtCustomField.text = arrSaddle[self.selectedSaddleId].value
            saddleId = String(arrSaddle[self.selectedSaddleId].id ?? 0)
        case .condition:
            self.myPickerView.selectRow(self.selectedConditionId, inComponent: 0, animated: true)
            txtCondition.txtCustomField.text = arrCondition[self.selectedConditionId].value
            conditionId = String(arrCondition[self.selectedConditionId].id ?? 0)
        case .none            : break
        }
        
    }
}

extension NewTackListingViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !txtViewDescription.text.isEmpty{
            self.placeholderLabel.textColor = .app_green_color
            self.viewDescription.setBorder(1, .app_green_color, 3)
        }else{
            self.viewDescription.setBorder(1, .app_green_color, 3)
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        if !txtViewDescription.text.isEmpty{
            UIView.animate(withDuration: 0.2, animations: {
                self.viewDescription.addSubview(self.placeholderLabel)
                self.placeholderLabel.frame.origin = CGPoint(x: ((self.viewDescription.bounds.width - self.txtViewDescription.bounds.width) / 2) + 5, y: 4)
                self.placeholderLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
                self.txtViewDescription.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
                self.placeholderLabel.textColor = .app_green_color
                self.viewDescription.setBorder(1, .app_green_color, 3)
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.txtViewDescription.addSubview(self.placeholderLabel)
                self.placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.txtViewDescription.font?.pointSize)! / 2)
                self.placeholderLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
                self.placeholderLabel.textColor = .lightGray
                self.viewDescription.setBorder(1, .horseListing_border_gray, 3)
            }, completion: nil)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewDescription.text.isEmpty{
            UIView.animate(withDuration: 0.2, animations: {
                self.txtViewDescription.addSubview(self.placeholderLabel)
                self.placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.txtViewDescription.font?.pointSize)! / 2)
                self.placeholderLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
                self.placeholderLabel.textColor = .lightGray
                self.viewDescription.setBorder(1, .horseListing_border_gray, 3)
            }, completion: nil)
        }else{
            placeholderLabel.textColor = .lightGray
            self.viewDescription.setBorder(1, .horseListing_border_gray, 3)
        }
    }
}
