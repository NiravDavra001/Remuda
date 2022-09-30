//
//  UploadImageViewModel.swift
//  remuda
//
//  Created by mac on 13/05/21.
//

import Foundation

struct UploadImageViewModel : Codable {
    
    let data : UploadImageData?
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UploadImageData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct UploadImageData : Codable {
    
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
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
