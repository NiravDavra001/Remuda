//
//  HorseListViewModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation

class HorseListViewModel : NSObject {
    
    var horseList : HorseListModel?
    
    func getHorseList(completion: @escaping (Bool,String) -> Void){
//        if !NetworkStatus.shared.isConnected{
//            NetworkStatus.shared.lastAPIAndParams = APIAndParams(APIName: .gethorseList, APIParams: [:])
//        }
        NetworkManager.share.getHorseList { (response) in
            switch response {
            case .success(let resData) :
                self.horseList = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
}
