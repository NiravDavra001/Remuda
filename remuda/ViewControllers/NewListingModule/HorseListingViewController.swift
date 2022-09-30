//
//  HorseListingViewController.swift
//  remuda
//
//  Created by Macmini on 26/04/21.
//
enum HorseTextFieldType {
    case breed
    case gender
    case age
    case color
    case height
    case discipline
   // case lifeTimeEarning
    case abilityLevel
    case breedingStock
    case radiograph
    case none
}
struct ImageModel {
    let id: Int?
    let image: UIImage?
    let videoUrl: URL?
}
struct AddHorseDetails {
    var title: String?
    var price: String?
    var description: String?
    var horse_breed: String?
    var gender: String?
    var age: String?
    var color: String?
    var discipline: String?
    var lifetimeearning: String?
    var ability_level: String?
    var breeding_stock: String?
    var radiographs: String?
    var height: String?
    var papers: String?
    var media: String?
    var thumbnail: String?
    var premium: Int?
}
import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class HorseListingViewController: UIViewController {
    @IBOutlet var collectionVIewPhotoVideo: UICollectionView!
    @IBOutlet var viewForAddphotoVideo: UIView!
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var viewPrice: UIView!
    @IBOutlet var viewDescription: UIView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var viewSignificantName: UIView!
    @IBOutlet var txtTitle: SkyFloatingLabelTextField!
    @IBOutlet var txtPrice: SkyFloatingLabelTextField!
    @IBOutlet var txtSignificant: SkyFloatingLabelTextField!
    @IBOutlet var txtViewDescription: UITextView!
    @IBOutlet var txtHorseBreed: CustomTextField!
    @IBOutlet var txtGender: CustomTextField!
    @IBOutlet var txtAge: CustomTextField!
    @IBOutlet var txtColor: CustomTextField!
    @IBOutlet var txtApproximateHands: CustomTextField!
    @IBOutlet var txtDiscipline: CustomTextField!
    @IBOutlet var btnPedigree: UIButton!
    @IBOutlet var viewLifeTimeEarning: UIView!
    @IBOutlet weak var txtLifeTimeEarning: SkyFloatingLabelTextField!
    @IBOutlet var txtAbilityLevel: CustomTextField!
    @IBOutlet var txtBreedingStock: CustomTextField!
    @IBOutlet var txtRadiographs: CustomTextField!
    @IBOutlet var pedigreeView: UIView!
    @IBOutlet var lblPhotoChoose: UILabel!
    @IBOutlet var lblPhotoCount: UILabel!
    @IBOutlet var lblDetails: UILabel!
    
    var arrCount: Int?
    var getPlanId: Int?
    //    weak var pickerView: UIPickerView?
    var myPickerView = UIPickerView()
    var arrHorseBreed = [Breed]()
    var arrDiscipline = [Discipline]()
    var arrGender = [Gender]()
    var arrColor = [Color]()
    var horseBreedId = String()
    var disciplineId = String()
    var genderId = String()
    var colorId = String()
    let horseDeleteViewModel = NewHorseListViewModel()
    var selectedPikerType =  HorseTextFieldType.none
    
    
    //MARK:- static data.
    let ageArray = (1...100).map { $0 * 1 }
    var arrAge = [String]()
    var arrApproximateHands = horseHeights
    var arrBreedingStock = ["Yes","No"]
    var arrAbilityLevel = ["Beginner Novice","Novice","Training","Modified","Preliminary","Intermediate","Advanced"]
    var arrRadiographs = ["Yes","No"]
    var arrLifeTimeEarnData = [String]()
    var imgArray = [ImageModel?]()
    var mediaData = [String]()
    var mediaThumbnail = String()
    var placeholderLabel : UILabel!
    var arrDetails : NewHorseListModel?
    let viewModel = NewHorseListViewModel()
    
    //MARK:- Manage selected pickerview items.
    var selectedHorseBreedId = 0
    var selectedHorseGender = 0
    var selectedHorseAgeId = 0
    var selectedHorseColorId = 0
    var selectedHorseHeightId = 0
    var selectedHorseDisciplineId = 0
    var selectedHorseLTEId = 0
    var selectedHorseAbilityLevelId = 0
    var selectedHorseBreedingId = 0
    var selectedHorseRadiographsId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpData()
        self.setPlaceholderForTextView()
//        txtLifeTimeEarning.text = "$"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.setUpCornerRadius(5)
        viewTitle.setBorder(1, .horseListing_border_gray, 3)
        viewPrice.setBorder(1, .horseListing_border_gray, 3)
        viewDescription.setBorder(1, .horseListing_border_gray, 3)
        viewSignificantName.setBorder(1, .horseListing_border_gray, 3)
        viewLifeTimeEarning.setBorder(1, .horseListing_border_gray, 3)
        pedigreeView.setBorder(1, .horseListing_border_gray, 3)    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            
            if let id = mainHorseChildId {
                self.horseDeleteViewModel.deleteHorseId.removeAll()
                self.horseDeleteViewModel.deleteHorseId["horseid"] = id
                horseChildId = 0
                mainHorseChildId = 0
                self.horseDeleteCallAPI()
            }
        }
    }
    
    private func setPlaceholderForTextView() {
        self.txtViewDescription.delegate = self
        self.txtViewDescription.tintColor = .app_green_color
        self.placeholderLabel = UILabel()
        self.placeholderLabel.text = "Description"
        self.placeholderLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.placeholderLabel.sizeToFit()
        self.txtViewDescription.addSubview(placeholderLabel)
        self.placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtViewDescription.font?.pointSize)! / 2)
        self.placeholderLabel.textColor = UIColor.lightGray
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
        self.arrHorseBreed.removeAll()
        self.arrDiscipline.removeAll()
        self.arrColor.removeAll()
        self.arrGender.removeAll()
        self.arrHorseBreed = categoryDetails?.data?.breed ?? []
        self.arrHorseBreed.removeFirst()
        self.arrDiscipline = categoryDetails?.data?.discipline ?? []
        self.arrDiscipline.removeFirst()
        self.arrColor = categoryDetails?.data?.color ?? []
        self.arrColor.removeFirst()
        self.arrGender = categoryDetails?.data?.gender ?? []
        self.arrGender.removeFirst()
        
        let lifetimeearn = stride(from: 100000, to: 500000, by: 5000)
        self.arrLifeTimeEarnData.append(contentsOf: lifetimeearn.map { String($0) })
        self.arrAge.append(contentsOf: ageArray.map { String($0) })
    }
    private func setUpUI(){
        myPickerView.dataSource = self
        myPickerView.delegate = self
        
        txtHorseBreed.txtCustomField.delegate = self
        txtGender.txtCustomField.delegate = self
        txtAge.txtCustomField.delegate = self
        txtColor.txtCustomField.delegate = self
        txtApproximateHands.txtCustomField.delegate = self
        txtDiscipline.txtCustomField.delegate = self
       // txtLifeTimeEarning.txtCustomField.delegate = self
        txtAbilityLevel.txtCustomField.delegate = self
        txtBreedingStock.txtCustomField.delegate = self
        txtRadiographs.txtCustomField.delegate = self
        
        txtHorseBreed.txtCustomField.inputView = myPickerView
        txtGender.txtCustomField.inputView = myPickerView
        txtAge.txtCustomField.inputView = myPickerView
        txtColor.txtCustomField.inputView = myPickerView
        txtApproximateHands.txtCustomField.inputView = myPickerView
        txtDiscipline.txtCustomField.inputView = myPickerView
        //txtLifeTimeEarning.txtCustomField.inputView = myPickerView
        txtAbilityLevel.txtCustomField.inputView = myPickerView
        txtBreedingStock.txtCustomField.inputView = myPickerView
        txtRadiographs.txtCustomField.inputView = myPickerView
        //        self.pickerView = myPickerView
        txtLifeTimeEarning.delegate = self
        collectionVIewPhotoVideo.dataSource = self
        collectionVIewPhotoVideo.delegate = self
        collectionVIewPhotoVideo.register(UINib(nibName: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue)
        collectionVIewPhotoVideo.register(UINib(nibName: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue)
        self.setNavigationBarSubVCTitle(navTitle: .yourHorseListing)
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
        self.txtSignificant.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.btnPedigree.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtSignificant.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtSignificant.titleColor = UIColor.personalInformationTFlabel
        self.btnPedigree.setTitleColor(.personalInformationTFlabel, for: .normal)
        self.txtSignificant.selectedTitleColor = .app_green_color
        self.txtSignificant.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtSignificant.tintColor = .app_green_color
        self.lblPhotoChoose.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblPhotoChoose.textColor = .app_lblUserLocation
        self.lblPhotoCount.textColor = .app_lblUserLocation
        self.lblPhotoCount.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))
        self.lblDetails.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        self.txtLifeTimeEarning.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtLifeTimeEarning.titleFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_12))!
        self.txtLifeTimeEarning.titleColor = UIColor.personalInformationTFlabel
        self.txtLifeTimeEarning.selectedTitleColor = .app_green_color
        self.txtLifeTimeEarning.placeholderFont = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        self.txtLifeTimeEarning.tintColor = .app_green_color
        
        self.txtHorseBreed.txtCustomField.placeholder = "Horse Breed"
        self.txtGender.txtCustomField.placeholder = "Horse Gender"
        self.txtAge.txtCustomField.placeholder = "Age"
        self.txtColor.txtCustomField.placeholder = "Color"
        self.txtApproximateHands.txtCustomField.placeholder = "Approximate Height"
        self.txtDiscipline.txtCustomField.placeholder = "Discipline"
        //self.txtLifeTimeEarning.txtCustomField.placeholder = "Life Time Earnings"
        self.txtAbilityLevel.txtCustomField.placeholder = "Ability Level"
        self.txtBreedingStock.txtCustomField.placeholder = "Breeding Stock"
        self.txtRadiographs.txtCustomField.placeholder = "Radiographs"
    }
    
    @IBAction func btnPedigreeAction(_ sender: UIButton) {
        self.pushViewController(controllerID: .CreatePedigreeVC, storyBoardID: .NewListing)
    }
    @IBAction func btnNext(_ sender: UIButton) {
        mediaData.removeAll()
        if imgArray.isEmpty {
            self.showAlert(message: "Please select image")
            return
        }
        if txtTitle.text == "" || txtTitle == nil {
            self.showAlert(message: getLocalizedString(key: .enterTitle))
            return
        }
        else if txtPrice.text == "" || txtPrice == nil {
            self.showAlert(message: getLocalizedString(key: .enterPrice))
            return
        }else if txtViewDescription.text == "" || txtViewDescription == nil {
            self.showAlert(message: getLocalizedString(key: .eneterDescription))
            return
        }else if txtHorseBreed.txtCustomField.text == "" || txtHorseBreed.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterHorseBreed))
            return
        }else if txtGender.txtCustomField.text == "" || txtGender.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterHorseBreed))
            return
        }else if txtAge.txtCustomField.text == "" || txtAge.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterHoeseAge))
            return
        }else if txtColor.txtCustomField.text == "" || txtColor.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterColor))
            return
        }else if txtApproximateHands.txtCustomField.text == "" || txtApproximateHands.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterApproximateHands))
            return
        }else if txtDiscipline.txtCustomField.text == "" || txtDiscipline.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterDiscipline))
            return
        }else if txtLifeTimeEarning.text == "" || txtLifeTimeEarning == nil {
            self.showAlert(message: getLocalizedString(key: .eneterLifeTimeEarning))
            return
        }else if txtSignificant.text == "" || txtSignificant == nil {
            self.showAlert(message: getLocalizedString(key: .enterSignificantNameOnPapers))
            return
        }else if txtAbilityLevel.txtCustomField.text == "" || txtAbilityLevel.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterAbilityLevel))
            return
        }else if txtBreedingStock.txtCustomField.text == "" || txtBreedingStock.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterBreedingStock))
            return
        }else if txtRadiographs.txtCustomField.text == "" || txtRadiographs.txtCustomField == nil {
            self.showAlert(message: getLocalizedString(key: .enterRadiographs))
            return
        }

        addHorseDetails.title = txtTitle.text
        addHorseDetails.price = txtPrice.text
        addHorseDetails.description = txtViewDescription.text
        addHorseDetails.horse_breed = horseBreedId
        addHorseDetails.gender = genderId
        addHorseDetails.age = txtAge.txtCustomField.text
        addHorseDetails.color = colorId
        addHorseDetails.discipline = disciplineId
        addHorseDetails.lifetimeearning = txtLifeTimeEarning.text
        addHorseDetails.ability_level = txtAbilityLevel.txtCustomField.text
        addHorseDetails.breeding_stock = txtBreedingStock.txtCustomField.text
        addHorseDetails.radiographs = txtRadiographs.txtCustomField.text
        addHorseDetails.height = txtApproximateHands.txtCustomField.text
        addHorseDetails.papers = txtSignificant.text
        addHorseDetails.premium = self.getPlanId
        
        let vc = self.loadViewController(Storyboard: .NewListing, ViewController: .ContactInfoVC) as! ContactInfoViewController
        vc.mode = .horse
        vc.imgArray = self.imgArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func horseDeleteCallAPI(){
        self.horseDeleteViewModel.deleteHorseListAPI{ (isFinished, message) in
            if isFinished {
                self.horseDeleteViewModel.deleteHorseId.removeAll()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

extension HorseListingViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imgArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let horseListingPhotosCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.NewListingPhotosCVCell.rawValue, for: indexPath) as? NewListingPhotosCollectionViewCell
        let photoVideoSelectionCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentifiers.PhotoVideoSelectionCVCell.rawValue, for: indexPath) as? PhotoVideoSelectionCollectionViewCell
        
        if indexPath.row == imgArray.count {
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

//MARK:- Upload videos and photos delegate.
extension HorseListingViewController: ListingPhotoSelectionDelegate{
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
extension HorseListingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

//MARK:- setUp UITextView
extension HorseListingViewController: UITextViewDelegate{
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

//MARK:- UITextFields open pickerView.
extension HorseListingViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedPikerType {
        case .breed           : return arrHorseBreed.count
        case .gender          : return arrGender.count
        case .age             : return arrAge.count
        case .color           : return arrColor.count
        case .height          : return arrApproximateHands.count
        case .discipline      : return arrDiscipline.count
       // case .lifeTimeEarning : return arrLifeTimeEarnData.count
        case .abilityLevel    : return arrAbilityLevel.count
        case .breedingStock   : return arrBreedingStock.count
        case .radiograph      : return arrRadiographs.count
        case .none            : return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedPikerType {
        case .breed           : return arrHorseBreed[row].value
        case .gender          : return arrGender[row].value
        case .age             : return arrAge[row]
        case .color           : return arrColor[row].value
        case .height          : return arrApproximateHands[row]
        case .discipline      : return arrDiscipline[row].value
       // case .lifeTimeEarning : return arrLifeTimeEarnData[row]
        case .abilityLevel    : return arrAbilityLevel[row]
        case .breedingStock   : return arrBreedingStock[row]
        case .radiograph      : return arrRadiographs[row]
        case .none            : return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedPikerType {
        case .breed           :
            txtHorseBreed.txtCustomField.text = arrHorseBreed[row].value
            horseBreedId = String(arrHorseBreed[row].id ?? 0)
            self.selectedHorseBreedId = row
        case .gender          :
            txtGender.txtCustomField.text = arrGender[row].value
            genderId = String(arrGender[row].id ?? 0)
            self.selectedHorseGender = row
        case .age             :
            txtAge.txtCustomField.text = arrAge[row]
            self.selectedHorseAgeId = row
        case .color           :
            txtColor.txtCustomField.text = arrColor[row].value
            colorId = String(arrColor[row].id ?? 0)
            self.selectedHorseColorId = row
        case .height          :
            txtApproximateHands.txtCustomField.text = arrApproximateHands[row]
            self.selectedHorseHeightId = row
        case .discipline      :
            txtDiscipline.txtCustomField.text = arrDiscipline[row].value
            disciplineId = String(arrDiscipline[row].id ?? 0)
            self.selectedHorseDisciplineId = row
//        case .lifeTimeEarning :
//            txtLifeTimeEarning.text = arrLifeTimeEarnData[row]
//            self.selectedHorseLTEId = row
        case .abilityLevel    :
            txtAbilityLevel.txtCustomField.text = arrAbilityLevel[row]
            self.selectedHorseAbilityLevelId = row
        case .breedingStock   :
            txtBreedingStock.txtCustomField.text = arrBreedingStock[row]
            self.selectedHorseBreedingId = row
        case .radiograph      :
            txtRadiographs.txtCustomField.text = arrRadiographs[row]
            self.selectedHorseRadiographsId = row
        case .none            : break
        }
    }
}

extension HorseListingViewController:  UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case txtHorseBreed.txtCustomField       : selectedPikerType    = .breed
        case txtGender.txtCustomField           : selectedPikerType    = .gender
        case txtAge.txtCustomField              : selectedPikerType    = .age
        case txtColor.txtCustomField            : selectedPikerType    = .color
        case txtApproximateHands.txtCustomField : selectedPikerType    = .height
        case txtDiscipline.txtCustomField       : selectedPikerType    = .discipline
       // case txtLifeTimeEarning.txtCustomField  : selectedPikerType    = .lifeTimeEarning
        case txtAbilityLevel.txtCustomField     : selectedPikerType    = .abilityLevel
        case txtBreedingStock.txtCustomField    : selectedPikerType    = .breedingStock
        case txtRadiographs.txtCustomField      : selectedPikerType    = .radiograph
        default                                 : selectedPikerType    = .none
        }
        self.myPickerView.reloadAllComponents()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.switchBasedNextTextField(textField)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldString = txtLifeTimeEarning.text, let range = Range(range, in: textFieldString) else {
            return false
        }
        let newString = textFieldString.replacingCharacters(in: range, with: string)
        if !newString.contains("$"){
            txtLifeTimeEarning.text = "$"
        }
        return true
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        
        switch selectedPikerType {
        case .breed           :
            self.myPickerView.selectRow(self.selectedHorseBreedId, inComponent: 0, animated: true)
            txtHorseBreed.txtCustomField.text = arrHorseBreed[self.selectedHorseBreedId].value
            horseBreedId = String(arrHorseBreed[self.selectedHorseBreedId].id ?? 0)
        case .gender          :
            self.myPickerView.selectRow(self.selectedHorseGender, inComponent: 0, animated: true)
            txtGender.txtCustomField.text = arrGender[self.selectedHorseGender].value
            genderId = String(arrGender[self.selectedHorseGender].id ?? 0)
        case .age             :
            self.myPickerView.selectRow(self.selectedHorseAgeId, inComponent: 0, animated: true)
            txtAge.txtCustomField.text = arrAge[self.selectedHorseAgeId]
        case .color           :
            self.myPickerView.selectRow(self.selectedHorseColorId, inComponent: 0, animated: true)
            txtColor.txtCustomField.text = arrColor[self.selectedHorseColorId].value
            colorId = String(arrColor[self.selectedHorseColorId].id ?? 0)
        case .height          :
            self.myPickerView.selectRow(self.selectedHorseAgeId, inComponent: 0, animated: true)
            txtApproximateHands.txtCustomField.text = arrApproximateHands[self.selectedHorseAgeId]
        case .discipline      :
            self.myPickerView.selectRow(self.selectedHorseDisciplineId, inComponent: 0, animated: true)
            txtDiscipline.txtCustomField.text = arrDiscipline[self.selectedHorseDisciplineId].value
            disciplineId = String(arrDiscipline[self.selectedHorseDisciplineId].id ?? 0)
//        case .lifeTimeEarning :
//            self.myPickerView.selectRow(self.selectedHorseLTEId, inComponent: 0, animated: true)
//            txtLifeTimeEarning.text = arrLifeTimeEarnData[self.selectedHorseLTEId]
        case .abilityLevel    :
            self.myPickerView.selectRow(self.selectedHorseAbilityLevelId, inComponent: 0, animated: true)
            txtAbilityLevel.txtCustomField.text = arrAbilityLevel[self.selectedHorseAbilityLevelId]
        case .breedingStock   :
            self.myPickerView.selectRow(self.selectedHorseBreedingId, inComponent: 0, animated: true)
            txtBreedingStock.txtCustomField.text = arrBreedingStock[self.selectedHorseBreedingId]
        case .radiograph      :
            self.myPickerView.selectRow(self.selectedHorseRadiographsId, inComponent: 0, animated: true)
            txtRadiographs.txtCustomField.text = arrRadiographs[self.selectedHorseRadiographsId]
        case .none            : break
        }
        
    }
}
