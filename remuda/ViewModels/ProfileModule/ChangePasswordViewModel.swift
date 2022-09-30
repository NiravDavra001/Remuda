//
//  ChangePasswordViewModel.swift
//  remuda
//
//  Created by Macmini on 24/07/21.
//

import Foundation

class ChangePasswordViewModel : NSObject {
    var dict = [String : Any]()
    func changeProfilePasswordAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.changeProfilePassword(params: dict) { (response) in
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
