//
//  HorseCategoryViewModel.swift
//  remuda
//
//  Created by Macmini on 11/06/21.
//

import Foundation

class HorseCategoryViewModel : NSObject {
    
    var getAllCategory : HorseCategoryModel?
    
    func getAllCategoryApi(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getAllCategory { (response) in
            switch response {
            case .success(let resData) :
                self.getAllCategory = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
