//
//  CreatePostViewModel.swift
//  remuda
//
//  Created by mac on 13/05/21.
//

import Foundation

class CreatePostViewModel : NSObject {
    
    func createPostAPI(params : CreatePostStruct,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.createNewHomeFeedPost(params: params) { (response) in
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
