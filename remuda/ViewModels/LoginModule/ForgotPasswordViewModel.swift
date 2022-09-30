//
//  ForgotPasswordViewModel.swift
//  remuda
//
//  Created by Macmini on 18/08/21.
//

import UIKit

class ForgotPasswordViewModel: NSObject {
    func callUserMailVerificationAPI(params : [String :Any] ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.reserPassword(params: params) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
 
