//
//  NetworkStatus.swift
//  Sleepbot
//
//

import Foundation
import Alamofire

struct APIAndParams {
    var APIName : APIName?
    var APIParams : [String : Any]?
}

class NetworkStatus {
    
    //MARK:-Properties
    static let shared = NetworkStatus()
    var isConnected: Bool = false
    var lastAPIAndParams = [APIAndParams]()
    
    private init() {
        
    }
    
    let reachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
                print("The network is not reachable")
                self.isConnected = false
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.isConnected = true
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                self.isConnected = true
//                self.callAPIOnInternetConnection(name: self.lastAPIAndParams)
            case .reachable(.cellular):
                print("The network is reachable over the cellular connection")
                self.isConnected = true
//                self.callAPIOnInternetConnection(name: self.lastAPIAndParams)
            }
        }
    }
    
    func callAPIOnInternetConnection(name : APIAndParams){
        switch name.APIName {
        case .gethorseList:
            NetworkManager.share.getHorseList { (response) in
                switch response {
                case .success(let resData):
                    print(resData)
                    break
                case.failure(let error):
                    print(error)
                    break
                }
            }
            break
        default:
            break
        }
    }
    
}
