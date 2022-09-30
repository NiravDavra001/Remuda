//
//  RegisterModel.swift
//  remuda
//
//  Created by mac on 09/04/21.
//

import Foundation


struct RegisterModel : Codable {
    
    var data : UserDetailsModel?
    var message : String?
    var success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UserDetailsModel.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}
struct UserDetailsModel : Codable {
    
    var age : Int?
    var city : String?
    var createdAt : String?
    var email : String?
    var id : Int?
    var mobile : String?
    var first_name : String?
    var last_name : String?
    var token : String?
    var updatedAt : String?
    var isNew : Int?
    var login_id: String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case city = "city"
        case createdAt = "created_at"
        case email = "email"
        case id = "id"
        case mobile = "mobile"
        case first_name = "first_name"
        case last_name = "last_name"
        case token = "token"
        case updatedAt = "updated_at"
        case isNew = "is_new"
        case login_id = "login_id"
    }
    init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        login_id = try values.decodeIfPresent(String.self, forKey: .login_id)
    }
}
