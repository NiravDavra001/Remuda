//
//  NewTackListViewModel.swift
//  remuda
//
//  Created by mac on 07/05/21.
//

import Foundation
class NewTackListViewModel : NSObject {
    
    func addTackListAPI(params : AddTackDetails,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.addTackList(params: params) { (response) in
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
