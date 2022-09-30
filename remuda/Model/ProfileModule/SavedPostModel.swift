//
//  SavedPostModel.swift
//  remuda
//
//  Created by Macmini on 21/05/21.
//

import Foundation

struct SavedPostModel : Codable {
    
    let data : SavedData?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(SavedData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct SavedData : Codable {
    
    let createdAt : String?
    let id : Int?
    let postId : Int?
    let type : Int?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case postId = "post_id"
        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}


