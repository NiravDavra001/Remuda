//
//  ContryCodeModel.swift
//  Audici
//
//  Created by iMac on 18/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import Foundation


class ContryCodeModel : NSObject, NSCoding{

    var countryCode : String!
    var iso : String!
    var name : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        countryCode = dictionary["countryCode"] as? String
        iso = dictionary["Iso"] as? String
        name = dictionary["name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if countryCode != nil{
            dictionary["countryCode"] = countryCode
        }
        if iso != nil{
            dictionary["Iso"] = iso
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
        iso = aDecoder.decodeObject(forKey: "Iso") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if countryCode != nil{
            aCoder.encode(countryCode, forKey: "countryCode")
        }
        if iso != nil{
            aCoder.encode(iso, forKey: "Iso")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
    }
}
