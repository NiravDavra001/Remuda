
//
//  LoginModel.swift
//  remuda
//
//  Created by mac on 10/04/21.
//

import Foundation

struct LoginModel : Codable {
    
    let data : LoginDetails?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        print("captain 1")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("captain 2")
        data = try values.decodeIfPresent(LoginDetails.self, forKey: .data)
        print("captain 3")
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("captain 4")
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        print("captain 5")
    }
    
}

struct LoginDetails : Codable {
    
    let age : String?
    let city : String?
    let createdAt : String?
    let email : String?
    let id : Int?
    let mobile : String?
    let name : String?
    let token : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case city = "city"
        case createdAt = "created_at"
        case email = "email"
        case id = "id"
        case mobile = "mobile"
        case name = "name"
        case token = "token"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        print("captain 6")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("captain 7")
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("captain 8")
        city = try values.decodeIfPresent(String.self, forKey: .city)
        print("captain 9")
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("captain 10")
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("captain 11")
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("captain 12")
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("captain 13")
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("captain 14")
        token = try values.decodeIfPresent(String.self, forKey: .token)
        print("captain 15")
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("captain 16")
    }
    
}


