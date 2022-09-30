//
//  tackListViewModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation
class tackListViewModel : NSObject {
    
    var tackList : TackListModel?
    
    func getTackList(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getTackList { (response) in
            switch response {
            case .success(let resData) :
                self.tackList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
