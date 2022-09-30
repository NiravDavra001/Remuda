//
//  HorseParentDetailModel.swift
//  remuda
//
//  Created by Macmini on 05/08/21.
//

import Foundation

struct HorseParentDetailModel : Codable {
    
    var success : Bool?
    var message : String?
    var data : ParentDetail?
    var isOpened: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ParentDetail.self, forKey: .data)
    }
    
}

struct ParentDetail : Codable {
    let id : Int?
    let userId : Int?
    let title : String?
    let price : Int?
    let descriptionField : String?
    let age : Int?
    let color : Int?
    let height : String?
    let horseBreed : Int?
    let discipline : Int?
    let pedigree : String?
    let papers : String?
    let abilityLevel : String?
    let breedingStock : String?
    let radiographs : String?
    let premium : Int?
    let shares : Int?
    let gender : Int?
    let posttime : String?
    let lifetimeearning : String?
    let location : String?
    let email : String?
    let mobile : String?
    let media : String?
    let thumbnail : String?
    let sireId : Int?
    let damnId : Int?
    let borndate : Int?
    let registernumber : String?
    let sires : [Sire]?
    let damn : [Damn]?
    let isSave : Int?
    let firstName : String?
    let lastName : String?
    let image : String?
    let isChild : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case title = "title"
        case price = "price"
        case descriptionField = "description"
        case age = "age"
        case color = "color"
        case height = "height"
        case horseBreed = "horse_breed"
        case discipline = "discipline"
        case pedigree = "pedigree"
        case papers = "papers"
        case abilityLevel = "ability_level"
        case breedingStock = "breeding_stock"
        case radiographs = "radiographs"
        case premium = "premium"
        case shares = "shares"
        case gender = "gender"
        case posttime = "posttime"
        case lifetimeearning = "lifetimeearning"
        case location = "location"
        case email = "email"
        case mobile = "mobile"
        case media = "media"
        case thumbnail = "thumbnail"
        case sireId = "sire_id"
        case damnId = "damn_id"
        case borndate = "borndate"
        case registernumber = "registernumber"
        case sires = "sires"
        case damn = "damn"
        case isSave = "is_save"
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "image"
        case isChild = "is_child"
    }
}

struct Damn : Codable {
    
    let id : Int?
    let title : String?
    let borndate : Int?
    let registernumber : String?
    let createdAt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case borndate = "borndate"
        case registernumber = "registernumber"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Sire : Codable {
    
    let id : Int?
    let title : String?
    let borndate : Int?
    let registernumber : String?
    let createdAt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case borndate = "borndate"
        case registernumber = "registernumber"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
}
