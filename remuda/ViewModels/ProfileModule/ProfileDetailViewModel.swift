//
//  ProfileDetailViewModel.swift
//  remuda
//
//  Created by Macmini on 20/05/21.
//

import Foundation

class ProfileDetailViewModel : NSObject {
    
    var getUserProfileList : ProfileDetailModel?
    
    func getUserProfileAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getMyProfile{ (response) in
            switch response {
            case .success(let resData) :
                self.getUserProfileList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
