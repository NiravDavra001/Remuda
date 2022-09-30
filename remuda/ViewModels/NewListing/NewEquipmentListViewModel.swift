//
//  NewEquipmentListViewModel.swift
//  remuda
//
//  Created by Macmini on 07/05/21.
//

import Foundation

class NewEquipmentListViewModel : NSObject {
    func addEquipmentListAPI(params : AddEquipmentDetails,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.addEquipmentList(params: params) { (response) in
            switch response {
            case .success(let resData) :
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
