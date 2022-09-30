//
//  ProfileModel.swift
//  remuda
//
//  Created by Priya Dhola on 10/04/21.
//

import Foundation

struct ProfileModel {
    let title: ProfileData
}

enum ProfileData: String{
    case personalInformation = "Personal Information"
    case bookmarks = "Bookmarks"
    case support = "Support"
}
