//
//  CreateAccountProfileViewController.swift
//  remuda
//
//  Created by mac on 13/09/21.
//

import UIKit



class CreateAccountProfileViewController: UIViewController {
    @IBOutlet weak var ProfileTapView: UIView!
    @IBOutlet weak var btnEditImage: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ImgProfile: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var LblTitle: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ImgProfile.sd_setImage(with: nil, placeholderImage: UIImage(named: "profilePlaceholder"), context: nil)
       
    }
    
    override func viewDidLayoutSubviews() {
        ImgProfile.setRoundedView()
    }
    @IBAction func btnEditImageTap(_ sender: UIButton) {
        showAlert()
        
    }
    @IBAction func btnNextAction(_ sender: UIButton) {
        if self.ImgProfile.image !=  UIImage(named: "profilePlaceholder") || self.ImgProfile != nil{
            let PhoneVC = self.loadViewController(Storyboard: .Main, ViewController: .CreateAccountPhoneVC) as! CreateAccountPhoneViewController
            PhoneVC.profileImage = self.ImgProfile.image
            self.navigationController?.pushViewController(PhoneVC, animated: true)
        }else{
            self.showAlert(message: "Please select Image.")
        }
        
    }
}
extension CreateAccountProfileViewController{
    func showAlert() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
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
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension CreateAccountProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
            self.dismiss(animated: true, completion: nil)
            self.ImgProfile.image = image
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
