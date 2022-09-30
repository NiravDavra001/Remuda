//
//  MyProfileModel.swift
//  remuda
//
//  Created by mac on 13/05/21.
//

import Foundation

struct MyProfileModel : Codable {
    
    let data : MyProfileData?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        print("my rpofile model  : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("my rpofile model  : ",#line)
        data = try values.decodeIfPresent(MyProfileData.self, forKey: .data)
        print("my rpofile model  : ",#line)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}

struct MyProfileData : Codable {
    
    let age : String?
    let city : String?
    let createdAt : String?
    let email : String?
    let firstName : String?
    let id : Int?
    let image : String?
    let isNew : Int?
    let lastName : String?
    let loginId : String?
    let loginType : Int?
    let mobile : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case city = "city"
        case createdAt = "created_at"
        case email = "email"
        case firstName = "first_name"
        case id = "id"
        case image = "image"
        case isNew = "is_new"
        case lastName = "last_name"
        case loginId = "login_id"
        case loginType = "login_type"
        case mobile = "mobile"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        print("my rpofile model  : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("my rpofile model  : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("my rpofile model  : ",#line)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        print("my rpofile model  : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("my rpofile model  : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("my rpofile model  : ",#line)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        print("my rpofile model  : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("my rpofile model  : ",#line)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        print("my rpofile model  : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("my rpofile model  : ",#line)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        print("my rpofile model  : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("my rpofile model  : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("my rpofile model  : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("my rpofile model  : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
