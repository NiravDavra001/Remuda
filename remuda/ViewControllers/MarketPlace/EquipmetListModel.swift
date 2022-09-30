//
//  EquipmetListModel.swift
//  remuda
//
//  Created by mac on 22/04/21.
//

import Foundation

struct EquipmetListModel : Codable {
    
    let data : [AllEquipmentListModel]?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AllEquipmentListModel].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct AllEquipmentListModel : Codable {
    
    let createdAt : String?
    let equipmentImage : [EquipmentImageList]?
    let posttime : Int?
    let premium : Int?
    let price : Int?
    let shares : Int?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case equipmentImage = "equipment_image"
        case posttime = "posttime"
        case premium = "premium"
        case price = "price"
        case shares = "shares"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        equipmentImage = try values.decodeIfPresent([EquipmentImageList].self, forKey: .equipmentImage)
        posttime = try values.decodeIfPresent(Int.self, forKey: .posttime)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}
struct EquipmentImageList : Codable {
    let equipment_id : Int?
    let media : String?
    
    enum CodingKeys: String, CodingKey {
        case equipment_id = "equipment_id"
        case media = "media"
    }
    
    init(from decoder: Decoder) throws {
        print("equip line no is : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("equip line no is : ",#line)
        equipment_id = try values.decodeIfPresent(Int.self, forKey: .equipment_id)
        print("equip line no is : ",#line)
        media = try values.decodeIfPresent(String.self, forKey: .media)
    }
            
}
