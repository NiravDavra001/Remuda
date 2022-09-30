//
//  TacksFilterViewModel.swift
//  remuda
//
//  Created by Macmini on 23/06/21.
//

import Foundation

class TacksFilterViewModel : NSObject {
    
    var tacksFilterData: TacksFilterModel?
    var data = [String:Any]()
    func getFilterTack(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getTackFilterData(params: data) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.tacksFilterData = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
