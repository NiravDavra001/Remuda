//
//  NewTackListingModel.swift
//  remuda
//
//  Created by mac on 07/05/21.
//

import Foundation

struct NewTackListingModel : Codable {
    
    let data : NewListing?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(NewListing.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}

struct NewListing : Codable {
    
    let conditions : String?
    let createdAt : String?
    let descriptionField : String?
    let email : String?
    let id : Int?
    let location : String?
    let media : [String]?
    let mobile : String?
    let posttime : Int?
    let price : String?
    let saddles : String?
    let title : String?
    let type : String?
    let updatedAt : String?
    let userId : Int?
    
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
        case price = "price"
        case saddles = "saddles"
        case title = "title"
        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conditions = try values.decodeIfPresent(String.self, forKey: .conditions)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        media = try values.decodeIfPresent([String].self, forKey: .media)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        posttime = try values.decodeIfPresent(Int.self, forKey: .posttime)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        saddles = try values.decodeIfPresent(String.self, forKey: .saddles)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
