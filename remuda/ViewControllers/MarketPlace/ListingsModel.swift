//
//  ListingsModel.swift
//  remuda
//
//  Created by Macmini on 14/07/21.
//

import Foundation

struct ListingsModel : Codable {
    
    var success : Bool?
    var message : String?
    var data : [ListingData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([ListingData].self, forKey: .data)
    }
    
}

struct ListingData : Codable {
    
    var id : Int?
    var title : String?
    var media : String?
    var types : Int?
    var price : Int?
    var status : Int?
    var createdAt : String?
    let thumbnail : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case media = "media"
        case types = "types"
        case price = "price"
        case thumbnail = "thumbnail"
        case status = "status"
        case createdAt = "createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        types = try values.decodeIfPresent(Int.self, forKey: .types)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
    
}
