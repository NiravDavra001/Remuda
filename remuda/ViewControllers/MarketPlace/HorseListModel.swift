//
//  HorseListModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation

struct HorseListModel : Codable {
    
    let data : [AllHorseListModel]?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AllHorseListModel].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct AllHorseListModel : Codable {
    
    let createdAt : String?
    let horseImage : [HorseImageList]?
    let posttime : Int?
    let premium : Int?
    let price : Int?
    let shares : Int?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case horseImage = "horse_image"
        case posttime = "posttime"
        case premium = "premium"
        case price = "price"
        case shares = "shares"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        horseImage = try values.decodeIfPresent([HorseImageList].self, forKey: .horseImage)
        posttime = try values.decodeIfPresent(Int.self, forKey: .posttime)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}

struct HorseImageList : Codable {
    let horse_id : Int?
    let media : String?
    
    enum CodingKeys: String, CodingKey {
        case horse_id = "horse_id"
        case media = "media"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        horse_id = try values.decodeIfPresent(Int.self, forKey: .horse_id)
        media = try values.decodeIfPresent(String.self, forKey: .media)
    }
            
}
