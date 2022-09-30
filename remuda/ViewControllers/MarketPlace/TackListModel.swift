//
//  TackListModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation

struct TackListModel : Codable {
    
    let data : [AllTackListModel]?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AllTackListModel].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct AllTackListModel : Codable {
    
    let createdAt : String?
    let tackImage : [TackImageList]?
    let posttime : Int?
    let premium : Int?
    let price : Int?
    let shares : Int?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case tackImage = "tack_image"
        case posttime = "posttime"
        case premium = "premium"
        case price = "price"
        case shares = "shares"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        tackImage = try values.decodeIfPresent([TackImageList].self, forKey: .tackImage)
        posttime = try values.decodeIfPresent(Int.self, forKey: .posttime)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}
struct TackImageList : Codable {
    let tack_id : Int?
    let media : String?
    
    enum CodingKeys: String, CodingKey {
        case tack_id = "tack_id"
        case media = "media"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tack_id = try values.decodeIfPresent(Int.self, forKey: .tack_id)
        media = try values.decodeIfPresent(String.self, forKey: .media)
    }
            
}
