//
//  SaveHorseTackEquipmentsViewModel.swift
//  remuda
//
//  Created by Macmini on 15/07/21.
//

import Foundation

class SaveHorseTackEquipmentsViewModel : NSObject {
    var dict = [String : Any]()
    func saveHorseTackEquipmentsAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.saveMarketplaceListing(params: dict) { (response) in
            switch response {
            case .success(let resData) :
                print("Saved",resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
