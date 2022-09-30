//
//  CommentPostViewModel.swift
//  remuda
//
//  Created by Macmini on 02/06/21.
//

import Foundation

class CommentPostViewModel : NSObject {
    
    var dict = [String : Any]()
    
    func commentPostAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.commentPost(params: dict){ (response) in
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
