//
//  TacksFilterModel.swift
//  remuda
//
//  Created by Macmini on 23/06/21.
//

import Foundation

struct TacksFilterModel : Codable {
    
    let data : [FilterTack]?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FilterTack].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct FilterTack : Codable {
    
    let conditions : Int?
    let createdAt : String?
    let descriptionField : String?
    let email : String?
    let id : Int?
    let location : String?
    let media : String?
    let mobile : String?
    let posttime : String?
    let premium : Int?
    let price : Int?
    let saddles : Int?
    let shares : Int?
    let title : String?
    let type : Int?
    let updatedAt : String?
    let userId : String?
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case conditions = "conditions"
        case createdAt = "created_at"
        case descriptionField = "description"
        case email = "email"
        case id = "id"
        case location = "location"
        case media = "media"
        case mobile = "mobile"
        case posttime = "posttime"
        case premium = "premium"
        case price = "price"
        case saddles = "saddles"
        case shares = "shares"
        case title = "title"
        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conditions = try values.decodeIfPresent(Int.self, forKey: .conditions)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        posttime = try values.decodeIfPresent(String.self, forKey: .posttime)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        saddles = try values.decodeIfPresent(Int.self, forKey: .saddles)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
    
}
