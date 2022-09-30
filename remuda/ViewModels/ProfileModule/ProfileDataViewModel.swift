//
//  ProfileDataViewModel.swift
//  remuda
//
//  Created by Macmini on 19/05/21.
//

import Foundation

class ProfileDataViewModel : NSObject {
    
    var profileList : ProfileDataModel?
    
    func getProfileAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getProfileList{ (response) in
            switch response {
            case .success(let resData) :
                self.profileList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
