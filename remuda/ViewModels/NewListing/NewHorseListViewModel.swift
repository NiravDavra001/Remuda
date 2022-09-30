//
//  NewHorseListViewModel.swift
//  remuda
//
//  Created by Macmini on 05/05/21.
//

import Foundation
///step7
class NewHorseListViewModel : NSObject {
    
    var dict = [String : Any]()
    var deleteHorseId = [String : Any]()
    var updateHorseDict = [String : Any]()
    var getAllHorseParentDetail: HorseParentDetailModel?
    var horseId = [String:Any]()
    
    func addHorseListAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.addHorseList(params: dict) { (response) in
            switch response {
            case .success(let resData) :
                completion(true,"\(resData.data?.id ?? 0)")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func deleteHorseListAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.deleteHorseList(params: deleteHorseId) { (response) in
            switch response {
            case .success(let resData) :
                completion(true,"\(resData.data?.id ?? 0)")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func updateHorseListAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.updateHorseList(params: dict) { (response) in
            switch response {
            case .success(let resData) :
                completion(true,"\(resData.data?.id ?? 0)")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getHorseParentAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getHorseParentList(params: horseId) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.getAllHorseParentDetail = resData
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func shareCountAPI(params : [String :Any] ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.shareCount(params: params) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
