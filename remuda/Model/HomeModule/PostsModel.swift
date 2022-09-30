//
//  PostsModel.swift
//  remuda
//
//  Created by mac on 14/05/21.
//

import Foundation

struct PostsModel : Codable {
    
    var data : [PostsData]?
    var message : String?
    var success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        print("line no o9f  : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no o9f  : ",#line)
        data = try values.decodeIfPresent([PostsData].self, forKey: .data)
        print("line no o9f  : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("line no o9f  : ",#line)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}
struct PostsData : Codable {
    
    var createdAt : String?
    var firstName : String?
    var id : Int?
    var image : String?
    var isLike : Int?
    var isSave : Int?
    var lastName : String?
    var message : String?
    var media : String?
    var TotalLike : Int?
    var TotalComment : Int?
    var type : Int?
    var updatedAt : String?
    var userId : Int?
    var post_id: Int?
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case firstName = "first_name"
        case id = "id"
        case image = "image"
        case isLike = "is_like"
        case isSave = "is_save"
        case lastName = "last_name"
        case message = "message"
        case media = "media"
        case TotalLike = "TotalLike"
        case TotalComment = "TotalComment"
        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case post_id = "post_id"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isLike = try values.decodeIfPresent(Int.self, forKey: .isLike)
        isSave = try values.decodeIfPresent(Int.self, forKey: .isSave)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        TotalLike = try values.decodeIfPresent(Int.self, forKey: .TotalLike)
        TotalComment = try values.decodeIfPresent(Int.self, forKey: .TotalComment)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
    
}
