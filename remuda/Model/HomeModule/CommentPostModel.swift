//
//  CommentPostModel.swift
//  remuda
//
//  Created by Macmini on 02/06/21.
//

import Foundation

struct CommentPostModel : Codable {
    
    let data : PostCommentModel?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PostCommentModel.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct PostCommentModel : Codable {
    
    let comment : String?
    let createdAt : String?
    let id : Int?
    let parentId : String?
    let postId : String?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case createdAt = "created_at"
        case id = "id"
        case parentId = "parent_id"
        case postId = "post_id"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
        postId = try values.decodeIfPresent(String.self, forKey: .postId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
