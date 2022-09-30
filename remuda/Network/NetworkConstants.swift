//
//  NetworkConstants.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import Foundation
import Moya
import UIKit

enum API {
    case register(params : [String : Any])
    case login(params : [String : Any])
    case emailExist(params : [String : Any])
    case gethorseList
    case getEquipmentList
    case getTackList
    case getAllCategory
    case getHorseDetails(params : [String : Any])
    case getEquipmentDetails(params : [String : Any])
    case getTackDetails(params : [String : Any])
    case addHorseList(params : [String : Any])
    case horseDelete(params : [String : Any])
    case horseUpdate(params : [String : Any])
    case addEquipmentList(params : AddEquipmentDetails)
    case addTackList(params : AddTackDetails)
    case getProfile
    case updateProfile(params : UpdateProfile)
    case updateUserImage(params : [String : Any])
    case createPost(params : CreatePostStruct)
    case getAllPost(params : [String : Any])
    case getMyProfile
    case getSavePost
    case saveLikePost(params : [String : Any])
    case getComment(postId: Int)
    case getHorseParentsList(params : [String : Any])
    case commentPost(params : [String : Any])
    case horseFilter(params : [String : Any])
    case equipmentFilter(params : [String : Any])
    case tackfilter(params : [String : Any])
    case getMarketplaceListings
    case itemSelling(params : [String : Any])
    case saveListing(params : [String : Any])
    case getSaveListing
    case changePass(params : [String : Any])
    case resetPassword(params : [String : Any])
    case verifyUser(params : [String : Any])
    case shareCount(params : [String : Any])
    case checkVersion
}

extension API : TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .getEquipmentList ,.gethorseList , .getTackList,.addEquipmentList,.addTackList,.getAllPost, .getProfile ,.createPost,  .updateProfile, .getSavePost, .getMarketplaceListings, .getSaveListing :
            return ["Content-Type":"multipart/form-data", "Authorization" : UserDefaultManager.share.getStringUserDefaultValue(key: .appToken)]
        case .getHorseDetails,.getEquipmentDetails,.getTackDetails, .saveLikePost, .commentPost, .getAllCategory,.getMyProfile,.addHorseList, .horseDelete, .horseUpdate,.checkVersion :
            return ["Content-Type":"application/json", "Authorization" : UserDefaultManager.share.getStringUserDefaultValue(key: .appToken)]
        case .updateUserImage,.getComment,.horseFilter,.equipmentFilter,.tackfilter, .itemSelling, .saveListing,.getHorseParentsList:
            return ["Content-Type":"application/json", "Authorization" : UserDefaultManager.share.getStringUserDefaultValue(key: .appToken)]
        default :
            return ["Content-Type":"application/json" ,"Authorization" : UserDefaultManager.share.getStringUserDefaultValue(key: .appToken)]
            
        }
    }
    
    var baseURL: URL {
        return URL(string: "http://3.141.250.237:3000/api/v1")!
        
    }
    
    var path: String {
        switch self {
        
        case .register:
            return "/user/register"
        case .login:
            return "/user/login"
        case .emailExist:
            return "/user/emailVerification"
        case .gethorseList:
            return "/user/horse-list"
        case .getEquipmentList:
            return "/user/equipment-List"
        case .getTackList:
            return "/user/tack-list"
        case .getHorseDetails:
            return "/user/getHorseProfile"
        case .getEquipmentDetails:
            return "/user/getEquipmentProfile"
        case .getTackDetails:
            return "/user/getTackProfile"
        case .addHorseList:
            return "/user/horse"
        case .horseDelete:
            return "/horseDelete"
        case .horseUpdate:
            return "/horseUpdate"
        case .addEquipmentList:
            return "/user/equipment"
        case .addTackList:
            return "/user/tack"
        case .updateProfile:
            return "/user/update-profile"
        case .updateUserImage:
            return "/user/imageUpload"
        case .createPost:
            return "/user/createPost"
        case .getAllPost:
            return "/getAllPost"
        case .getProfile:
            return "/getProfile"
        case .getMyProfile:
            return "//getMyProfile"
        case .getSavePost:
            return "/getSavePost"
        case .saveLikePost:
            return "/saveLikePost"
        case .getComment:
            return "/getComment"
        case .getHorseParentsList:
            return "/user/horse-list"
        case .commentPost:
            return "/commentPost"
        case .getAllCategory:
            return "/getAllCategory"
        case .horseFilter:
            return "/horseFilter"
        case .equipmentFilter:
            return "/equipmentFilter"
        case .tackfilter:
            return "/tackfilter"
        case .getMarketplaceListings:
            return "/horseSelling"
        case .itemSelling:
            return "/itemSelling"
        case .saveListing:
            return "/save_listing"
        case .getSaveListing:
            return "/getSaveListing"
        case .changePass:
            return "/changePass"
        case .resetPassword:
            return "/resetPassword"
        case .verifyUser:
            return "/verifyUser"
        case .shareCount:
            return "/shareCount"
        case .checkVersion:
            return "/checkversion"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .emailExist:
            return .post
        case .gethorseList:
            return .get
        case .getEquipmentList:
            return .get
        case .getTackList:
            return .get
        case .getHorseDetails:
            return .post
        case .getEquipmentDetails:
            return .post
        case .getTackDetails:
            return .post
        case .addHorseList:
            return .post
        case .horseDelete:
            return .post
        case .horseUpdate:
            return .post
        case .addEquipmentList:
            return .post
        case .addTackList:
            return .post
            
        case .updateProfile:
            return .post
        case .updateUserImage:
            return .post
        case .createPost:
            return .post
        case .getAllPost:
            return .get
        case .getProfile:
            return .get
        case .getMyProfile:
            return .get
        case .getSavePost:
            return .get
        case .saveLikePost:
            return .post
        case .getComment:
            return .get
        case .getHorseParentsList:
            return .get
        case .commentPost:
            return .post
        case .getAllCategory:
            return .get
        case .horseFilter:
            return .get
        case .equipmentFilter:
            return .get
        case .tackfilter:
            return .get
        case .getMarketplaceListings:
            return .get
        case .itemSelling:
            return .post
        case .saveListing:
            return .post
        case .getSaveListing:
            return .get
        case .changePass:
            return .post
        case .resetPassword:
            return .post
        case .verifyUser:
            return .post
        case .shareCount:
            return .post
        case .checkVersion:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .register(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .login(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .emailExist(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .gethorseList:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getEquipmentList:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getTackList:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getAllCategory:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .getHorseDetails(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .getEquipmentDetails(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .getTackDetails(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .addHorseList(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .horseDelete(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .horseUpdate(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .addEquipmentList(let params):
            var multipartData = [MultipartFormData]()
            
            if let title = params.title , title != "" {
                let Provience = MultipartFormData.init(provider: .data(title.data(using: String.Encoding.utf8) ?? Data()), name: "title")
                multipartData.append(Provience)
            }
            
            if let price = params.price , price != "" {
                let Provience = MultipartFormData.init(provider: .data(price.data(using: String.Encoding.utf8) ?? Data()), name: "price")
                multipartData.append(Provience)
            }
            
            if let description = params.ViewDescription , description != "" {
                let Provience = MultipartFormData.init(provider: .data(description.data(using: String.Encoding.utf8) ?? Data()), name: "description")
                multipartData.append(Provience)
            }
            
            if let condition = params.condition , condition != "" {
                let Provience = MultipartFormData.init(provider: .data(condition.data(using: String.Encoding.utf8) ?? Data()), name: "condition")
                multipartData.append(Provience)
            }
            
            if let location = params.location , location != "" {
                let Provience = MultipartFormData.init(provider: .data(location.data(using: String.Encoding.utf8) ?? Data()), name: "location")
                multipartData.append(Provience)
            }
            
            if let mobile = params.mobile , mobile != "" {
                let Provience = MultipartFormData.init(provider: .data(mobile.data(using: String.Encoding.utf8) ?? Data()), name: "mobile")
                multipartData.append(Provience)
            }
            if let premium = params.premium , premium != 0 {
                let Provience = MultipartFormData.init(provider: .data(String(premium).data(using: String.Encoding.utf8) ?? Data()), name: "premium")
                multipartData.append(Provience)
            }
            if let email = params.email , email != "" {
                let Provience = MultipartFormData.init(provider: .data(email.data(using: String.Encoding.utf8) ?? Data()), name: "email")
                multipartData.append(Provience)
            }
            if let media = params.media{
                let Provience = MultipartFormData.init(provider: .data(media.data(using: String.Encoding.utf8) ?? Data()), name: "media")
                multipartData.append(Provience)
            }
            if let thumbnail = params.thumbnail{
                let Provience = MultipartFormData.init(provider: .data(thumbnail.data(using: String.Encoding.utf8) ?? Data()), name: "thumbnail")
                multipartData.append(Provience)
            }
            return .uploadCompositeMultipart(multipartData, urlParameters: [ : ])
        case .addTackList(let params):
            var multipartData = [MultipartFormData]()
            
            if let title = params.title , title != "" {
                let Provience = MultipartFormData.init(provider: .data(title.data(using: String.Encoding.utf8) ?? Data()), name: "title")
                multipartData.append(Provience)
            }
            
            if let price = params.price , price != "" {
                let Provience = MultipartFormData.init(provider: .data(price.data(using: String.Encoding.utf8) ?? Data()), name: "price")
                multipartData.append(Provience)
            }
            
            if let description = params.description , description != "" {
                let Provience = MultipartFormData.init(provider: .data(description.data(using: String.Encoding.utf8) ?? Data()), name: "description")
                multipartData.append(Provience)
            }
            if let tackType = params.tackType , tackType != "" {
                let Provience = MultipartFormData.init(provider: .data(tackType.data(using: String.Encoding.utf8) ?? Data()), name: "type")
                multipartData.append(Provience)
            }
            if let premium = params.premium , premium != 0 {
                let Provience = MultipartFormData.init(provider: .data(String(premium).data(using: String.Encoding.utf8) ?? Data()), name: "premium")
                multipartData.append(Provience)
            }
            if let tackSaddles = params.tackSaddles , tackSaddles != "" {
                let Provience = MultipartFormData.init(provider: .data(tackSaddles.data(using: String.Encoding.utf8) ?? Data()), name: "saddles")
                multipartData.append(Provience)
            }
            if let tackCondition = params.tackCondition , tackCondition != "" {
                let Provience = MultipartFormData.init(provider: .data(tackCondition.data(using: String.Encoding.utf8) ?? Data()), name: "condition")
                multipartData.append(Provience)
            }
            if let location = params.location , location != "" {
                let Provience = MultipartFormData.init(provider: .data(location.data(using: String.Encoding.utf8) ?? Data()), name: "location")
                multipartData.append(Provience)
            }
            
            if let mobile = params.mobile , mobile != "" {
                let Provience = MultipartFormData.init(provider: .data(mobile.data(using: String.Encoding.utf8) ?? Data()), name: "mobile")
                multipartData.append(Provience)
            }
            
            if let email = params.email , email != "" {
                let Provience = MultipartFormData.init(provider: .data(email.data(using: String.Encoding.utf8) ?? Data()), name: "email")
                multipartData.append(Provience)
            }
            if let media = params.media{
                let Provience = MultipartFormData.init(provider: .data(media.data(using: String.Encoding.utf8) ?? Data()), name: "media")
                multipartData.append(Provience)
            }
            if let thumbnail = params.thumbnail{
                let Provience = MultipartFormData.init(provider: .data(thumbnail.data(using: String.Encoding.utf8) ?? Data()), name: "thumbnail")
                multipartData.append(Provience)
            }
            return .uploadCompositeMultipart(multipartData, urlParameters: [ : ])
            
        case .updateProfile(let params):
            var multipartData = [MultipartFormData]()
            
            if let first_name = params.first_name , first_name != "" {
                let Provience = MultipartFormData.init(provider: .data(first_name.data(using: String.Encoding.utf8) ?? Data()), name: "first_name")
                multipartData.append(Provience)
            }
            
            if let last_name = params.last_name , last_name != "" {
                let Provience = MultipartFormData.init(provider: .data(last_name.data(using: String.Encoding.utf8) ?? Data()), name: "last_name")
                multipartData.append(Provience)
            }
            
            if let city = params.city , city != "" {
                let Provience = MultipartFormData.init(provider: .data(city.data(using: String.Encoding.utf8) ?? Data()), name: "city")
                multipartData.append(Provience)
            }
            if let mobile = params.mobile , mobile != "" {
                let Provience = MultipartFormData.init(provider: .data(mobile.data(using: String.Encoding.utf8) ?? Data()), name: "mobile")
                multipartData.append(Provience)
            }
            if let email = params.email , email != "" {
                let Provience = MultipartFormData.init(provider: .data(email.data(using: String.Encoding.utf8) ?? Data()), name: "email")
                multipartData.append(Provience)
            }
            if let horsePlanId = params.horsePlanId{
                let Provience = MultipartFormData.init(provider: .data(String(horsePlanId).data(using: String.Encoding.utf8) ?? Data()), name: "horse_plan_id")
                multipartData.append(Provience)
            }
            if let tackPlanId = params.tackPlanId{
                let Provience = MultipartFormData.init(provider: .data(String(tackPlanId).data(using: String.Encoding.utf8) ?? Data()), name: "tack_plan_id")
                multipartData.append(Provience)
            }
            if let equipmentPlanId = params.equipmentPlanId{
                let Provience = MultipartFormData.init(provider: .data(String(equipmentPlanId).data(using: String.Encoding.utf8) ?? Data()), name: "equipment_plan_id")
                multipartData.append(Provience)
            }
            if let image = params.image{
                let Provience = MultipartFormData.init(provider: .data(image.data(using: String.Encoding.utf8) ?? Data()), name: "image")
                multipartData.append(Provience)
            }
            return .uploadCompositeMultipart(multipartData, urlParameters: [ : ])
            
        case .updateUserImage(params: let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .createPost(let params):
            
            var multipartData = [MultipartFormData]()
            
            if let message = params.message {
                let Provience = MultipartFormData.init(provider: .data(message.data(using: String.Encoding.utf8) ?? Data()), name: "message")
                multipartData.append(Provience)
            }
            if let media = params.media{
                let Provience = MultipartFormData.init(provider: .data(media.data(using: String.Encoding.utf8) ?? Data()), name: "media")
                multipartData.append(Provience)
            }
            if let thumbnail = params.thumbnail{
                let Provience = MultipartFormData.init(provider: .data(thumbnail.data(using: String.Encoding.utf8) ?? Data()), name: "thumbnail")
                multipartData.append(Provience)
            }
            return .uploadMultipart(multipartData)
            
            
        case .getAllPost(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return  .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        //MARK: - Get All Comments
        case .getComment(let postId):
            let post = ["post_id" : postId] as [String : Any]
            return .requestParameters(parameters: post, encoding: URLEncoding.queryString)
        case .getHorseParentsList(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return  .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getProfile:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getMyProfile:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getSavePost:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
            
        case .saveLikePost(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .commentPost(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            
            return .requestData(parameterInData)
        case .horseFilter(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return  .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .equipmentFilter(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return  .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .tackfilter(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return  .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getMarketplaceListings:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .itemSelling(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .saveListing(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .getSaveListing:
            return  .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .changePass(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .resetPassword(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .verifyUser(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
            
        case .shareCount(let params):
            var parameterInData = Data()
            do {
                parameterInData =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch  {
                print("Could not convert on data")
            }
            return .requestData(parameterInData)
        case .checkVersion :
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
}
