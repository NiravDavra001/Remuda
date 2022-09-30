//
//  CreateNewPostViewController.swift
//  remuda
//
//  Created by Macmini on 21/04/21.
//

import UIKit
import KMPlaceholderTextView
import AWSS3
import AWSCognito
import AVKit
import AVFoundation
import MobileCoreServices

struct CreatePostStruct {
    var message : String?
    var media : String?
    var thumbnail: String?
}

class CreateNewPostViewController: UIViewController {
    @IBOutlet var txtViewNewPost: KMPlaceholderTextView!
    @IBOutlet var btnAddPhotoVideo: UIButton!
    @IBOutlet var imgProfilePhoto: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var btnPost: UIButton!
    var viewModel = CreatePostViewModel()
    var delegate: TableviewReloadDelegate?
    var discription: String?
    var mediaData = [String]()
    var mediaImages = [String]()
    let bucketName = "remuda"
    var s3URL: URL?
    var dispatchGrp = DispatchGroup()
    var postMediaImage = [UIImage]()
    var postMediaURL = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        s3URL = AWSS3.default().configuration.endpoint.url!
    }
    
    func createPostCallAPI(postData: CreatePostStruct){
        showActivityIndicator(uiView: self.view)
        
        viewModel.createPostAPI(params: postData) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.delegate?.reloadTableview()
                self.popViewController()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfilePhoto.setRoundedView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    
    func setUpUI(){
        let userDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: ProfileDetailModel.self, key: .storeProfile)
        let fname = userDetails?.data?.firstName ?? ""
        let lname = userDetails?.data?.lastName ?? ""
        self.lblUserName.text = "\(fname) \(lname)"
        let imgUrl = userDetails?.data?.image
        self.imgProfilePhoto.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "profile_Icon"), options: [.continueInBackground], completed: nil)
        self.title = ViewControllerTitle.home.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
        
        let textContainerInset = 16 * UIScreen.main.bounds.width / 343
        txtViewNewPost.textContainerInset = UIEdgeInsets(top: textContainerInset , left: textContainerInset, bottom: textContainerInset, right: textContainerInset)
        txtViewNewPost.placeholder = "Write your message..."
        txtViewNewPost.placeholderColor = .label_bookmarks_postGrey_color
        txtViewNewPost.textColor = .black
        txtViewNewPost.font = UIFont(name: FontName.Regular.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        
        lblUserName.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
        txtViewNewPost.setBorder(1, .button_border_color, 5)
        btnAddPhotoVideo.tintColor = .label_bookmarks_postGrey_color
        btnAddPhotoVideo.backgroundColor = .selectPhoto_background
        btnAddPhotoVideo.setUpCornerRadius(5)
        btnAddPhotoVideo.titleLabel?.font = UIFont(name: FontName.SemiBold.rawValue , size: setFontSizeAsPerDeviceHeight(currentSize: .Size_14))
        btnPost.setUpCornerRadius(5)
        btnPost.tintColor = .white
    }
    func manageUploadButton(btnPostUserInteraction: Bool, btnPostAlpha: CGFloat, btnAddUserInteraction: Bool, btnAddAlpha: CGFloat) {
        self.btnPost.isUserInteractionEnabled = btnPostUserInteraction
        self.btnPost.alpha = btnPostAlpha
        self.btnAddPhotoVideo.isUserInteractionEnabled = btnAddUserInteraction
        self.btnAddPhotoVideo.alpha = btnAddAlpha
    }
    func uploadImage(endCompletion: @escaping () -> ()) {
        if !(self.postMediaImage.isEmpty){
            print("Image upload start...")
            
            showActivityIndicator(uiView: self.view)
            for i in 0...postMediaImage.count - 1 {
                self.dispatchGrp.enter()
                DispatchQueue.global(qos: .background).async {
                    AWSS3Manager.shared.uploadImage(image: self.postMediaImage[i]) { (progress) in
                        self.manageUploadButton(btnPostUserInteraction: false, btnPostAlpha: 0.5, btnAddUserInteraction: false, btnAddAlpha: 0.5)
                        print("Uploading progress: \(progress)")
                    } completion: { (uploadedFileUrl, error) in
                       
                        self.manageUploadButton(btnPostUserInteraction: true, btnPostAlpha: 1, btnAddUserInteraction: true, btnAddAlpha: 1)
                        self.dispatchGrp.leave()
                        if let finalPath = uploadedFileUrl as? String {
                            let a = "Uploaded file url: " + finalPath
                            print(a)
                            self.mediaData.append(finalPath)
                            self.mediaImages.append(finalPath)
                           
                        } else {
                            print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                        }
                    }
                    
                }
            }
        }

        self.dispatchGrp.notify(queue: .main) {
            print("Image called")
            hideActivityIndicator(uiView: self.view)
            endCompletion()
        }

    }
    func uploadVideo(endCompletion: @escaping () -> ()) {
        if !(self.postMediaURL.isEmpty){
            print("Video upload start...")
            for i in 0...postMediaURL.count - 1 {
                showActivityIndicator(uiView: self.view)
                self.dispatchGrp.enter()
                DispatchQueue.global(qos: .background).async {
                    AWSS3Manager.shared.uploadVideo(videoUrl: self.postMediaURL[i]) { (progress) in
                        self.manageUploadButton(btnPostUserInteraction: false, btnPostAlpha: 0.5, btnAddUserInteraction: false, btnAddAlpha: 0.5)
                        print("Uploading progress: \(progress)")
                    } completion: { (uploadedFileUrl, error) in
                        if let finalPath = uploadedFileUrl as? String {
                            let a = "Uploaded file url: " + finalPath
                            print(a)
                            self.mediaData.append(finalPath)
                            let image = createThumbnailOfVideoFromRemoteUrl(url: finalPath){
                                self.showAlert(message: "An unexpected error occurred while uploading your image, please try again later")
                            }
                            //MARK:- video thumbnail.
                            AWSS3Manager.shared.uploadImage(image: image ?? UIImage()) { (progress) in
                                print("Uploading progress: \(progress)")
                            } completion: { (uploadedFileUrl, error) in
                                hideActivityIndicator(uiView: self.view)
                                self.dispatchGrp.leave()
                                self.manageUploadButton(btnPostUserInteraction: true, btnPostAlpha: 1, btnAddUserInteraction: true, btnAddAlpha: 1)
                                if let finalPath = uploadedFileUrl as? String {
                                    let a = "Uploaded file url: " + finalPath
                                    print(a)
                                    self.mediaImages.append(finalPath)
                                } else {
                                    print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                                }
                            }
                        } else {
                            print("Error: \(error?.localizedDescription ?? "Unknown error.")")
                        }
                    }
                    
                }
            }
        }

        self.dispatchGrp.notify(queue: .main) {
            print("Video called")
            endCompletion()
        }
    }
    
    @IBAction func btnAddPhotoVideo(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        let selectImage = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        imagePickerController.videoMaximumDuration = 45.00
        selectImage.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
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
        selectImage.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.modalPresentationStyle = .overCurrentContext
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        selectImage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(selectImage, animated: true, completion: nil)
    }
    @IBAction func btnPost(_ sender: UIButton) {
        
        if txtViewNewPost.text == "" && postMediaURL.isEmpty && postMediaImage.isEmpty {
            showAlert(message: "Please enter Data")
        }
        else{
            uploadImage {
                self.uploadVideo {
                    print("Allll done..")
                    createPostStruct.media = self.mediaData.joined(separator: ",")
                    createPostStruct.thumbnail = self.mediaImages.joined(separator: ",")
                    createPostStruct.message = self.txtViewNewPost.text
                    self.createPostCallAPI(postData: createPostStruct)
                }
            }
        }
    }
}

extension CreateNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func createTemporaryURLforVideoFile(url: URL) -> URL {
           /// Create the temporary directory.
           let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
           /// create a temporary file for us to copy the video to.
        let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(url.lastPathComponent )
           /// Attempt the copy.
           do {
            try FileManager().copyItem(at: url.absoluteURL, to: temporaryFileURL)
           } catch {
               print("There was an error copying the video file to the temporary location.")
           }

           return temporaryFileURL as URL
       }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String{
            if CFStringCompare(mediaType as CFString?, kUTTypeMovie, []) == .compareEqualTo {
                let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                if let movieName = videoUrl?.absoluteURL{
                    print("movieName test = \(movieName)")
                    let finalMovieName = createTemporaryURLforVideoFile(url: movieName)
                    print("final Movie Name = \(finalMovieName)")
                    self.postMediaURL.append(finalMovieName)
                }
            }
        }
        if  let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
            print("image = \(image)")
            self.postMediaImage.append(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

