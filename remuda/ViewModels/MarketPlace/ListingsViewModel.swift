//
//  ListingsViewModel.swift
//  remuda
//
//  Created by Macmini on 14/07/21.
//

import Foundation

class ListingsViewModel : NSObject {
    
    var listingsList : ListingsModel?
    var dict = [String : Any]()
    
    func getMarketplaceListingsList(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getMarketplaceListings { (response) in
            switch response {
            case .success(let resData) :
                self.listingsList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func changeListingsStatus(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.changeMarketPlaceStatus(params: dict) { (response) in
            switch response {
            case .success(let resData) :
                print("Successfully status changed...", resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
}
