//
//  NewHorseListModel.swift
//  remuda
//
//  Created by Macmini on 05/05/21.
//

import Foundation

struct NewHorseListModel: Codable {
    
    let success : Bool?
    let message : String?
    let data : AddNewHorseListModel?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(AddNewHorseListModel.self, forKey: .data)
    }
}

struct AddNewHorseListModel : Codable {

    let id : Int?
    let userId : Int?
    let title : String?
    let price : String?
    let descriptionField : String?
    let age : String?
    let color : String?
    let height : String?
    let horseBreed : String?
    let discipline : String?
    let gender : String?
    let pedigree : String?
    let papers : String?
    let abilityLevel : String?
    let breedingStock : String?
    let radiographs : String?
    let location : String?
    let email : String?
    let mobile : String?
    let sire : String?
    let foalto : String?
    let media : String?
    let lifetimeearning : String?
    let posttime : Int?
    let expireDate : String?
    let thumbnail : String?
    let borndate : String?
    let status : Int?
    let types : Int?
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
        case pedigree = "pedigree"
        case papers = "papers"
        case abilityLevel = "ability_level"
        case breedingStock = "breeding_stock"
        case radiographs = "radiographs"
        case location = "location"
        case email = "email"
        case mobile = "mobile"
        case sire = "sire"
        case foalto = "foalto"
        case media = "media"
        case lifetimeearning = "lifetimeearning"
        case posttime = "posttime"
        case expireDate = "expire_date"
        case thumbnail = "thumbnail"
        case borndate = "borndate"
        case status = "status"
        case types = "types"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        
        print(#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print(#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print(#line)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        print(#line)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        print(#line)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        print(#line)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        print(#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print(#line)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        print(#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print(#line)
        horseBreed = try values.decodeIfPresent(String.self, forKey: .horseBreed)
        print(#line)
        discipline = try values.decodeIfPresent(String.self, forKey: .discipline)
        print(#line)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        print(#line)
        pedigree = try values.decodeIfPresent(String.self, forKey: .pedigree)
        print(#line)
        papers = try values.decodeIfPresent(String.self, forKey: .papers)
        print(#line)
        abilityLevel = try values.decodeIfPresent(String.self, forKey: .abilityLevel)
        print(#line)
        breedingStock = try values.decodeIfPresent(String.self, forKey: .breedingStock)
        print(#line)
        radiographs = try values.decodeIfPresent(String.self, forKey: .radiographs)
        print(#line)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        print(#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print(#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print(#line)
        sire = try values.decodeIfPresent(String.self, forKey: .sire)
        print(#line)
        foalto = try values.decodeIfPresent(String.self, forKey: .foalto)
        print(#line)
        media = try values.decodeIfPresent(String.self, forKey: .media)
        print(#line)
        lifetimeearning = try values.decodeIfPresent(String.self, forKey: .lifetimeearning)
        print(#line)
        posttime = try values.decodeIfPresent(Int.self, forKey: .posttime)
        print(#line)
        expireDate = try values.decodeIfPresent(String.self, forKey: .expireDate)
        print(#line)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        print(#line)
        borndate = try values.decodeIfPresent(String.self, forKey: .borndate)
        print(#line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        print(#line)
        types = try values.decodeIfPresent(Int.self, forKey: .types)
        print(#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print(#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}
