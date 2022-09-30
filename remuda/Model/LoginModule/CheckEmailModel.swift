//
//  CheckEmailModel.swift
//  remuda
//
//  Created by mac on 20/04/21.
//

import Foundation
//{
//    "success": false,
//    "message": "The email has already been taken."
//}
struct CheckEmailModel : Codable {
    
    
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        print("line no ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("line no ",#line)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}
