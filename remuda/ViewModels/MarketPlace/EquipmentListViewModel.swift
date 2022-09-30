//
//  EquipmentListViewModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation
class EquipmentListViewModel : NSObject {
    
    var equipmentList : EquipmetListModel?
    
    func getEquipmentList(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getEquipmentList { (response) in
            switch response {
            case .success(let resData) :
                self.equipmentList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
