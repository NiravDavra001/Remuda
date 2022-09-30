//
//  GooglePlacesAPICity.swift
//  remuda
//
//  Created by Macmini on 19/07/21.
//

import Foundation
import UIKit
import GooglePlaces

class GooglePlacesAPICity: NSObject  {
    public var cityName = String()
    static let shared = GooglePlacesAPICity()
    
    func grabCityName(completion: @escaping(_ cityName: String) -> ()) {
        print("City:")
    }
    func presentVC(completion: @escaping() -> ()) {
        
    }
}
