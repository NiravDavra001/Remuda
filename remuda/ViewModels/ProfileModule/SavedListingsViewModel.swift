//
//  SavedListingsViewModel.swift
//  remuda
//
//  Created by Macmini on 17/07/21.
//

import Foundation

class SavedListingsViewModel : NSObject {
    
    var getSavedListingData : SavedListingsModel?
    
    func getSavedListAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getSavedListings{ (response) in
            switch response {
            case .success(let resData) :
                self.getSavedListingData = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
