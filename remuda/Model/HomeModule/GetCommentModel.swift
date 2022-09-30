//
//  GetCommentModel.swift
//  remuda
//
//  Created by Macmini on 27/05/21.
//

import Foundation

struct GetCommentModel : Codable {
    
    let data : [CommentDetail]?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("get comment details : ",#line)
        data = try values.decodeIfPresent([CommentDetail].self, forKey: .data)
        print("get comment details : ",#line)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        print("get comment details : ",#line)
        
    }
    
}

struct CommentDetail : Codable {
    let id : Int?
    let postId : Int?
    let userId : Int?
    let parentId : Int?
    let firstName : String?
    let lastName : String?
    let image : String?
    let comment : String?
    let createdAt : String?
    let updatedAt : String?
    let childs : [Child]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case postId = "post_id"
        case userId = "user_id"
        case parentId = "parent_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "image"
        case comment = "comment"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case childs = "childs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        childs = try values.decodeIfPresent([Child].self, forKey: .childs)
    }
}

struct Child : Codable {
    
    let id : Int?
    let postId : Int?
    let userId : Int?
    let parentId : Int?
    let firstName : String?
    let lastName : String?
    let image : String?
    let comment : String?
    let createdAt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case postId = "post_id"
        case userId = "user_id"
        case parentId = "parent_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "image"
        case comment = "comment"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
