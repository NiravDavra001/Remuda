//
//  SavedPostViewModel.swift
//  remuda
//
//  Created by Macmini on 21/05/21.
//

import Foundation

class SavedPostViewModel : NSObject {
    
    var getSavedPostData : PostsModel?
    
    func getSavedListAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getSavedPost{ (response) in
            switch response {
            case .success(let resData) :
                self.getSavedPostData = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
