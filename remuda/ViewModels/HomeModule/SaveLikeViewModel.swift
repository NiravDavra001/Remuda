//
//  SaveLikeViewModel.swift
//  remuda
//
//  Created by Macmini on 21/05/21.
//

import Foundation

class SaveLikeViewModel : NSObject {
    
    var dict = [String : Any]()
    
    func saveLikeAPI(completion: @escaping (Bool,String) -> Void){
        
        NetworkManager.share.saveLikePost(params: dict) { (response) in
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
