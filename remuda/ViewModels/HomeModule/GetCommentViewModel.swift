//
//  GetCommentViewModel.swift
//  remuda
//
//  Created by Macmini on 27/05/21.
//

import Foundation

class GetCommentViewModel : NSObject {
    
    var getAllComments: GetCommentModel?
    var postId: Int?
    func getAllCommentAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getCommentList(params: postId ?? 0) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.getAllComments = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
