//
//  HorseCategoryModel.swift
//  remuda
//
//  Created by Macmini on 11/06/21.
//

import Foundation

struct HorseCategoryModel : Codable {
    
    var data : AllCategory?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AllCategory.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct AllCategory : Codable {
    
    var breed : [Breed]?
    var color : [Color]?
    var discipline : [Discipline]?
    var gender : [Gender]?
    var condition : [Condition]?
    var saddle : [Saddle]?
    var id : Int?
    var type : [Type]?
    var tackCondition : [TackCondition]?
    
    enum CodingKeys: String, CodingKey {
        case breed = "breed"
        case color = "color"
        case discipline = "discipline"
        case gender = "gender"
        case saddle = "saddle"
        case condition = "condition"
        case id = "id"
        case type = "type"
        case tackCondition = "tack_condition"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        breed = try values.decodeIfPresent([Breed].self, forKey: .breed)
    //        color = try values.decodeIfPresent([Color].self, forKey: .color)
    //        discipline = try values.decodeIfPresent([Discipline].self, forKey: .discipline)
    //        gender = try values.decodeIfPresent([Gender].self, forKey: .gender)
    //        saddle = try values.decodeIfPresent([Saddle].self, forKey: .saddle)
    //        condition = try values.decodeIfPresent([Condition].self, forKey: .condition)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        type = try values.decodeIfPresent([Type].self, forKey: .type)
    //        tackCondition = try values.decodeIfPresent([TackCondition].self, forKey: .tackCondition)
    //    }
    
}

struct Discipline : Codable {
    
    let categoryId : Int?
    let id : Int?
    let value : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}

struct Color : Codable {
    
    let categoryId : Int?
    let id : Int?
    let value : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}

struct Breed : Codable {
    
    var categoryId : Int?
    var id : Int?
    var value : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    //
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}

struct Gender : Codable {
    
    let categoryId : Int?
    let id : Int?
    let value : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}

struct Saddle : Codable {
    
    var categoryId : Int?
    var id : Int?
    var value : String?
    var isSelected: Bool = false
    var isSaddle:Bool = false
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}

struct Condition : Codable {
    
    var categoryId : Int?
    var id : Int?
    var value : String?
    var isSelected: Bool = false
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    //
}

struct Type : Codable {
    
    let categoryId : Int?
    let id : Int?
    let value : String?
    var isSelected: Bool = false
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    //
}

struct TackCondition : Codable {
    
    let categoryId : Int?
    let id : Int?
    let value : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case value = "value"
    }
    
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //        value = try values.decodeIfPresent(String.self, forKey: .value)
    //    }
    
}
