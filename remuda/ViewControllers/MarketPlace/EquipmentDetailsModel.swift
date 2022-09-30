//
//  EquipmentDetailsModel.swift
//  remuda
//
//  Created by mac on 23/04/21.
//

import Foundation
import UIKit

struct EquipmentDetailsModel : Codable {
    
    var data : EquipmentDetails?
    var message : String?
    var success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(EquipmentDetails.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}
struct EquipmentDetails : Codable {
    let id : Int?
    let userId : String?
    let title : String?
    let price : Int?
    let descriptionField : String?
    let premium : Int?
    let shares : Int?
    let conditions : Int?
    let posttime : String?
    let location : String?
    let email : String?
    let mobile : String?
    let media : String?
    let firstName : String?
    let lastName : String?
    let image : String?
    let thumbnail : String?
    var isSave : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case title = "title"
        case price = "price"
        case descriptionField = "description"
        case premium = "premium"
        case shares = "shares"
        case conditions = "conditions"
        case posttime = "posttime"
        case location = "location"
        case email = "email"
        case mobile = "mobile"
        case media = "media"
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "image"
        case isSave = "is_save"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        conditions = try values.decodeIfPresent(Int.self, forKey: .conditions)
        posttime = try values.decodeIfPresent(String.self, forKey: .posttime)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isSave = try values.decodeIfPresent(Int.self, forKey: .isSave)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}
