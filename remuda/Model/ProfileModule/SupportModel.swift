//
//  SupportModel.swift
//  remuda
//
//  Created by mac on 03/09/21.
//

import Foundation
struct SupportModel {
    let title: SupportData
}
enum SupportData: String {
    case terms_conditions = "Terms and Conditions"
    case privacy_policy = "Privacy Policy"
    case about_us = "About US"
}
