//
//  HomeViewModel.swift
//  remuda
//
//  Created by mac on 14/05/21.
//

import Foundation

class HomeViewModel : NSObject {
    
    var homeFeedPost: PostsModel?
    var data = [String:Any]()
    func getAppHomeFeedPosts(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getHomeFeedPosts(params: data) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.homeFeedPost = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
