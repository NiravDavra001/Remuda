//
//  AppConstants.swift
//  remuda
//
//  Created by mac on 08/04/21.
//
import Foundation
import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

var CommonPicker = UIPickerView()
var storeRegisterData  = RegisterData()
let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

var horseFilterData: HorseCategoryModel?
var tmpHorseFilterData: HorseCategoryModel?

//               20BpxLjebl1fFc787BQ5115wCmFFJEUx8ExZ4pP4PDB158Lj28TsdRpdpCGkLD424Zo8PbiA0xTp7Jm6pCgHcRfbUHFVAeGEnqTDvpIL02xZ
var authToken = "20BpxLjebl1fFc787BQ5115wCmFFJEUx8ExZ4pP4PDB158Lj28TsdRpdpCGkLD424Zo8PbiA0xTp7Jm6pCgHcRfbUHFVAeGEnqTDvpIL02xZ"
var domainURL = "http://3.141.250.237:3000"
var addHorseDetails = AddHorseDetails()
var addEquipmentDetails = AddEquipmentDetails()
var addTackDetails = AddTackDetails()
var createPostStruct = CreatePostStruct()
var profileUpdate = UpdateProfile()

var mainHorseChildId: Int?
var horseChildId: Int?
var horseChildIds = [Int]()
var scalFactor :Double = 1

var pedigreeHorseData = PedigreeHorseChild()

func setFontSizeAsPerDeviceHeight(currentSize : FontSize) -> CGFloat{
    let size = currentSize.rawValue * UIScreen.main.bounds.height / 812
    return size
}

func isValidProfile() -> Bool {
    let userDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: ProfileDetailModel.self, key: .storeProfile)
    let fname = userDetails?.data?.firstName
    let lname = userDetails?.data?.lastName
    let address = userDetails?.data?.lastName
    if fname != nil && fname != "" && lname != nil && lname != "" || address != nil || address != ""{
        return true
    }else{
        return false
    }
}
func checkLoginViewController(storyBoard: StoryBoardIdentifiers, viewController: ViewControllerIdentifiers) {
    let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
    let homeViewController = storyBoard.instantiateViewController(identifier: viewController.rawValue)
    let navContller = UINavigationController(rootViewController: homeViewController)
    sceneDelegate?.window?.rootViewController = navContller
    sceneDelegate?.window?.makeKeyAndVisible()
}
var horseHeights = ["5 hh","6 hh","7 hh","8 hh","8.2 hh","9 hh","9.2 hh","10 hh","10.2 hh","11 hh","11.2 hh","12 hh","12.1 hh","12.2 hh","12.3 hh","13 hh","13.1 hh","13.2 hh","13.3 hh","14 hh","14.1 hh","14.2 hh","14.3 hh","15 hh","15.1 hh","15.2 hh","15.3 hh","16 hh","16.1 hh","16.2 hh","16.3 hh","17 hh","17.1 hh","17.2 hh","17.3 hh","18 hh","18.1 hh","18.2 hh","18.3 hh","19 hh","19.1 hh","19.2 hh","19.3 hh","20 hh","21 hh"]
var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

func showActivityIndicator(uiView: UIView) {
    //    uiView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    activityIndicator.style = .large
    activityIndicator.tintColor = .app_green_color
    activityIndicator.center = uiView.center
    uiView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
}

func hideActivityIndicator(uiView: UIView) {
    activityIndicator.removeFromSuperview()
    activityIndicator.stopAnimating()
}

func dateToString(date : Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: date)
    return myString
}

func getLocalizedString(key : localizedString) -> String{
    return key.getLocalizableString()
}

func convertTimeInDaysAgo(interval : Int?)->String{
    let time = TimeInterval(interval ?? 0)
    let myDate = Date(timeIntervalSince1970: time)
    let strDate =  dateToString(date: myDate)
    let counedTime = strDate.timeInterval(timeAgo: strDate, dateFormat: "yyyy-MM-dd HH:mm:ss",isSetTimezone: false)
    return counedTime
}

//MARK:- createThumbnailOfVideoFromRemoteUrl function used for create thumbnail from url.
func createThumbnailOfVideoFromRemoteUrl(url: String, completion: @escaping () -> Void) -> UIImage? {
    let asset = AVAsset(url: URL(string: url)!)
    let assetImgGenerate = AVAssetImageGenerator(asset: asset)
    assetImgGenerate.appliesPreferredTrackTransform = true
    let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
    do {
        let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        let thumbnail = UIImage(cgImage: img)
        return thumbnail
    } catch {
        print(error.localizedDescription)
        completion()
        return nil
    }
}

//MARK:- createImageDataFromURL function used for create image data array from url/UIImage.
func createImageDataFromURL(imageURL: String) -> [Data]{
    let imgUrl = imageURL
    var thumbnailImageData = [Data]()
    let imgArr : [String] = imgUrl.components(separatedBy: ",")
    _ = imgArr.compactMap({
        let mainURLS = URL(string: $0)
        
        let type = $0.components(separatedBy: ".")
        if type.last == "jpeg"{
            if mainURLS == nil{
                let image = UIImage(named: "AppIcon")
                let data = image?.jpegData(compressionQuality: 1.0)
                thumbnailImageData.append(data ?? Data())
            }else{
                if let url = mainURLS{
                    let data = try? Data(contentsOf: url)
                    thumbnailImageData.append(data ?? Data())
                }
            }
        }else if type.last == "MOV"{
            if mainURLS == nil{
                
                let image = UIImage(named: "AppIcon")
                let data = image?.jpegData(compressionQuality: 1.0)
                thumbnailImageData.append(data ?? Data())
            }else{
                let image = createThumbnailOfVideoFromRemoteUrl(url: $0){}
                let data = image?.jpegData(compressionQuality: 1.0)
                thumbnailImageData.append(data ?? Data())
            }
        }
    })
    return thumbnailImageData
}

//MARK:- set message for blank UITableview and UICollecttionview
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .app_green_color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}
extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .app_green_color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: FontName.Bold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
}
func getFileExetantions(fileType : String) -> Int{
    let fileExt = FileExtType.init(rawValue: fileType)
    return fileExt?.returnFileType() ?? 0
}
