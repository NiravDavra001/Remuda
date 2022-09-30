//
//  SavedListingsModel.swift
//  remuda
//
//  Created by Macmini on 17/07/21.
//

import Foundation

struct SavedListingsModel : Codable {
    
    let success : Bool?
    let message : String?
    let data : [SavedListingProfile]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([SavedListingProfile].self, forKey: .data)
    }
    
}

struct SavedListingProfile : Codable {
    
    let id : Int?
    let itemId : Int?
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
    let expireDate : String?
    let types : Int?
    let isSave : Int?
    let createdAt : String?
    let updatedAt : String?
    let saddles : Int?
    let type : Int?
    let conditions : Int?
    let thumbnail : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case itemId = "item_id"
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
        case expireDate = "expire_date"
        case types = "types"
        case isSave = "is_save"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case saddles = "saddles"
        case type = "type"
        case conditions = "conditions"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        itemId = try values.decodeIfPresent(Int.self, forKey: .itemId)
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
        expireDate = try values.decodeIfPresent(String.self, forKey: .expireDate)
        types = try values.decodeIfPresent(Int.self, forKey: .types)
        isSave = try values.decodeIfPresent(Int.self, forKey: .isSave)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        saddles = try values.decodeIfPresent(Int.self, forKey: .saddles)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        conditions = try values.decodeIfPresent(Int.self, forKey: .conditions)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
    
}
