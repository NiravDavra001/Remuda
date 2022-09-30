//
//  HorseDetailsModel.swift
//  remuda
//
//  Created by mac on 23/04/21.
//

import Foundation
import UIKit

struct HorseDetailsModel : Codable {
    var success : Bool?
    var message : String?
    var data : HorseDetails?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(HorseDetails.self, forKey: .data)
    }
}
struct HorseDetails : Codable {
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
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "image"
        case isSave = "is_save"
        case thumbnail = "thumbnail"
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
        pedigree = try values.decodeIfPresent(String.self, forKey: .pedigree)
        papers = try values.decodeIfPresent(String.self, forKey: .papers)
        abilityLevel = try values.decodeIfPresent(String.self, forKey: .abilityLevel)
        breedingStock = try values.decodeIfPresent(String.self, forKey: .breedingStock)
        radiographs = try values.decodeIfPresent(String.self, forKey: .radiographs)
        premium = try values.decodeIfPresent(Int.self, forKey: .premium)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        posttime = try values.decodeIfPresent(String.self, forKey: .posttime)
        lifetimeearning = try values.decodeIfPresent(String.self, forKey: .lifetimeearning)
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




