//
//  RegisterViewModel.swift
//  remuda
//
//  Created by mac on 09/04/21.
//

import Foundation

class RegisterViewModel : NSObject {
    
    func callRegisterAPI(params : [String :Any] ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callRegister(params: params) { (response) in
            switch response {
            case .success(let resData) :
                UserDefaultManager.share.setBoolUserDefaultValue(value: true, key: .isUserLogin)
                UserDefaultManager.share.setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeRegisterModel)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
