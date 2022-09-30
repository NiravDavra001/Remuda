//
//  HorseFilterViewModel.swift
//  remuda
//
//  Created by Macmini on 16/06/21.
//

import Foundation

class HorseFilterViewModel : NSObject {
    
    var horseFilterData: HorseFilterModel?
    var data = [String:Any]()
    func getFilterHoses(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getHorseFilterData(params: data) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.horseFilterData = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
