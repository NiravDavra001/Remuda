//
//  CreatePostModel.swift
//  remuda
//
//  Created by Macmini on 19/05/21.
//

import Foundation


struct CreatePostModel : Codable {
    
    let data : PostData?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PostData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct PostData : Codable {
    
    let firstName : String?
    let id : Int?
    let lastName : String?
    let userImage : [PostUserImage]?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case userImage = "user_image"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        userImage = try values.decodeIfPresent([PostUserImage].self, forKey: .userImage)
    }
    
}
struct PostUserImage : Codable {
    
    let createdAt : String?
    let id : Int?
    let media : String?
    let message : String?
    let thumbnail : String?
    let type : Int?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case media = "media"
        case message = "message"
        case thumbnail = "thumbnail"
        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
