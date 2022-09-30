//
//  LoginViewModel.swift
//  remuda
//
//  Created by mac on 09/04/21.
//

import Foundation
class LoginViewModel : NSObject {
    
    var dict = [String : Any]()
    
    func callLoginAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callLogin(params: dict) { (response) in
            switch response {
            case .success(let resData) :
                UserDefaultManager.share.setBoolUserDefaultValue(value: true, key: .isUserLogin)
                UserDefaultManager.share.setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeLoginModel)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
