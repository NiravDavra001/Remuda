//
//  ProfileDetailModel.swift
//  remuda
//
//  Created by Macmini on 20/05/21.
//

import Foundation

struct ProfileDetailModel : Codable {
    
    var data : UserProfile?
    var message : String?
    var success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UserProfile.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}

struct UserProfile : Codable {
    
    var age : String?
    var city : String?
    var createdAt : String?
    var email : String?
    var equipmentPlanDate : String?
    var equipmentPlanId : Int?
    var firstName : String?
    var horsePlanDate : String?
    var horsePlanId : Int?
    var id : Int?
    var image : String?
    var isNew : Int?
    var lastName : String?
    var loginId : String?
    var loginType : Int?
    var mobile : String?
    var tackPlanDate : String?
    var tackPlanId : Int?
    var token : String?
    var updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case city = "city"
        case createdAt = "created_at"
        case email = "email"
        case equipmentPlanDate = "equipment_plan_date"
        case equipmentPlanId = "equipment_plan_id"
        case firstName = "first_name"
        case horsePlanDate = "horse_plan_date"
        case horsePlanId = "horse_plan_id"
        case id = "id"
        case image = "image"
        case isNew = "is_new"
        case lastName = "last_name"
        case loginId = "login_id"
        case loginType = "login_type"
        case mobile = "mobile"
        case tackPlanDate = "tack_plan_date"
        case tackPlanId = "tack_plan_id"
        case token = "token"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        equipmentPlanDate = try values.decodeIfPresent(String.self, forKey: .equipmentPlanDate)
        equipmentPlanId = try values.decodeIfPresent(Int.self, forKey: .equipmentPlanId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        horsePlanDate = try values.decodeIfPresent(String.self, forKey: .horsePlanDate)
        horsePlanId = try values.decodeIfPresent(Int.self, forKey: .horsePlanId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        tackPlanDate = try values.decodeIfPresent(String.self, forKey: .tackPlanDate)
        tackPlanId = try values.decodeIfPresent(Int.self, forKey: .tackPlanId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}
