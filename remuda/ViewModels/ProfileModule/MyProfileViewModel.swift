//
//  MyProfileViewModel.swift
//  remuda
//
//  Created by mac on 13/05/21.
//

import Foundation

class MyProfileViewModel : NSObject {
    var getUserProfileList : ProfileDetailModel?
    

    
    func callMyProfileAPI(params : UpdateProfile,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.updateProfile(params: params) { (response) in
            switch response {
            case .success(let resData) :
                self.getUserProfileList = resData
                print(resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
