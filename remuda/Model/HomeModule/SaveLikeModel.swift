//
//  SaveLikeModel.swift
//  remuda
//
//  Created by Macmini on 21/05/21.
//

import Foundation

struct SaveLikeModel : Codable {
    
    struct RootClass : Codable {
        
        let data : SaveLike?
        let message : String?
        let success : Bool?
        
        enum CodingKeys: String, CodingKey {
            case data = "data"
            case message = "message"
            case success = "success"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            data = try values.decodeIfPresent(SaveLike.self, forKey: .data)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            success = try values.decodeIfPresent(Bool.self, forKey: .success)
        }
    }
}

struct SaveLike : Codable {
    
    let like : [String]?
    let unlike : [String]?
    let save : [String]?
    let unsave : [String]?
    
    enum CodingKeys: String, CodingKey {
        case like = "like"
        case unlike = "unlike"
        case save = "save"
        case unsave = "unsave"
    }
    
    init(from decoder: Decoder) throws {
        print("captain 6")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("captain 7")
        like = try values.decodeIfPresent([String].self, forKey: .like)
        print("captain 8")
        unlike = try values.decodeIfPresent([String].self, forKey: .unlike)
        print("captain 9")
        save = try values.decodeIfPresent([String].self, forKey: .save)
        print("captain 10")
        unsave = try values.decodeIfPresent([String].self, forKey: .unsave)
        print("captain 11")
        
    }
    
}
