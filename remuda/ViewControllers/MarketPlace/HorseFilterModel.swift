//
//  HorseFilterModel.swift
//  remuda
//
//  Created by Macmini on 16/06/21.
//

import Foundation

struct HorseFilterModel : Codable {
    
    let data : [FilterHorse]?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FilterHorse].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct FilterHorse : Codable {
    
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
    let gender : Int?
    let premium : Int?
    let shares : Int?
    let pedigree : String?
    let papers : String?
    let abilityLevel : String?
    let breedingStock : String?
    let radiographs : String?
    let sire : String?
    let foalto : String?
    let media : String?
    let lifetimeearning : String?
    let posttime : String?
    let location : String?
    let email : String?
    let mobile : String?
    let types : Int?
    let status : Int?
    let expireDate : String?
    let sireId : Int?
    let damnId : Int?
    let siredamn : Int?
    let borndate : Int?
    let registernumber : String?
    let thumbnail : String?
    let createdAt : String?
    let updatedAt : String?
    
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
        case gender = "gender"
        case premium = "premium"
        case shares = "shares"
        case pedigree = "pedigree"
        case papers = "papers"
        case abilityLevel = "ability_level"
        case breedingStock = "breeding_stock"
        case radiographs = "radiographs"
        case sire = "sire"
        case foalto = "foalto"
        case media = "media"
        case lifetimeearning = "lifetimeearning"
        case posttime = "posttime"
        case location = "location"
        case email = "email"
        case mobile = "mobile"
        case types = "types"
        case status = "status"
        case expireDate = "expire_date"
        case sireId = "sire_id"
        case damnId = "damn_id"
        case siredamn = "siredamn"
        case borndate = "borndate"
        case registernumber = "registernumber"
        case thumbnail = "thumbnail"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        color = try values.decodeIfPresent(Int.self, forKey: .color)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        horseBreed = try values.decodeIfPresent(Int.self, forKey: .horseBreed)
        discipline = try values.decodeIfPresent(Int.self, forKey: .discipline)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        pedigree = try values.decodeIfPresent(String.self, forKey: .pedigree)
        papers = try values.decodeIfPresent(String.self, forKey: .papers)
        abilityLevel = try values.decodeIfPresent(String.self, forKey: .abilityLevel)
        breedingStock = try values.decodeIfPresent(String.self, forKey: .breedingStock)
        radiographs = try values.decodeIfPresent(String.self, forKey: .radiographs)
        sire = try values.decodeIfPresent(String.self, forKey: .sire)
        foalto = try values.decodeIfPresent(String.self, forKey: .foalto)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        lifetimeearning = try values.decodeIfPresent(String.self, forKey: .lifetimeearning)
        posttime = try values.decodeIfPresent(String.self, forKey: .posttime)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        types = try values.decodeIfPresent(Int.self, forKey: .types)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        expireDate = try values.decodeIfPresent(String.self, forKey: .expireDate)
        sireId = try values.decodeIfPresent(Int.self, forKey: .sireId)
        damnId = try values.decodeIfPresent(Int.self, forKey: .damnId)
        siredamn = try values.decodeIfPresent(Int.self, forKey: .siredamn)
        borndate = try values.decodeIfPresent(Int.self, forKey: .borndate)
        registernumber = try values.decodeIfPresent(String.self, forKey: .registernumber)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
    
}
