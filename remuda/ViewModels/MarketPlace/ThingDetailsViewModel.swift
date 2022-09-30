//
//  ThingDetailsViewModel.swift
//  remuda
//
//  Created by mac on 23/04/21.
//

import Foundation
class ThingDetailsViewModel : NSObject {
    
    var horseDetails : HorseDetailsModel?
    var equipmentDetails : EquipmentDetailsModel?
    var tackDetails : TackDetailsModel?
    
    func getThingsDetails(thingID : Int, mode : MarketPlaceMode ,completion: @escaping (Bool,String) -> Void){
        var params = [String:Any]()
        if mode == .horse {
            params["horseid"] = thingID
            NetworkManager.share.getHorseDetails(params: params, completion: { (response) in
                   switch response {
                   case .success(let resData) :
                       self.horseDetails = resData
                       completion(true,"")
                   case .failure(let err) :
                       completion(false, err.localizedDescription)
                   }
            })
        }
        
        else if mode == .equipmment {
            params["equipmentid"] = thingID
            NetworkManager.share.getEquipmentDetails(params: params) { (response) in
                switch response {
                case .success(let resData) :
                    self.equipmentDetails = resData
                    completion(true,"")
                case .failure(let err) :
                    completion(false, err.localizedDescription)
                }
            }
        }
        
        else {
            params["tackid"] = thingID
            NetworkManager.share.getTackDetails(params: params) { (response) in
                switch response {
                case .success(let resData) :
                    self.tackDetails = resData
                    completion(true,"")
                case .failure(let err) :
                    completion(false, err.localizedDescription)
                }
            }
        }
        
    }

}
