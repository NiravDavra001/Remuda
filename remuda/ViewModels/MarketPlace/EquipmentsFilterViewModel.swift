//
//  EquipmentsFilterViewModel.swift
//  remuda
//
//  Created by Macmini on 23/06/21.
//

import Foundation

class EquipmentsFilterViewModel : NSObject {
    
    var equipmentsFilterData: EquipmentsFilterModel?
    var data = [String:Any]()
    func getFilterEquipments(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getEquipmentFilterData(params: data) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.equipmentsFilterData = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
