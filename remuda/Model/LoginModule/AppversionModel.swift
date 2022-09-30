//
//  AppversionModel.swift
//  remuda
//
//  Created by mac on 15/09/21.
//

import Foundation
struct AppversionModel : Codable {
    let success : Bool?
    let message : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
