//
//  CheckEmailViewModel.swift
//  remuda
//
//  Created by mac on 20/04/21.
//

import Foundation

class CheckEmailViewModel : NSObject {
    
    func callUserMailVerificationAPI(params : [String :Any] ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.verifyEmail(params: params) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func callSocialMediaLogin(params : [String :Any] ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callRegister(params: params) { (response) in
            switch response {
            case .success(let resData) :
                UserDefaultManager.share.setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}

