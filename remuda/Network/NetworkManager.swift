//
//  NetworkManager.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import Foundation
import Moya

class NetworkManager : NSObject {
    
    static let share = NetworkManager()
    let provider = MoyaProvider<API>()
    
    func callRegister(params : [String:Any],completion:@escaping(Result<RegisterModel,Error>)->Void){
        provider.request(.register(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callLogin(params : [String:Any],completion:@escaping(Result<LoginModel,Error>)->Void){
        provider.request(.login(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //    CheckEmailModel
    func verifyEmail(params : [String:Any],completion:@escaping(Result<CheckEmailModel,Error>)->Void){
        provider.request(.emailExist(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    //MARK: for check App version
    func getVersionApp(completion:@escaping(Result<AppversionModel,Error>)->Void){
        provider.request(.checkVersion) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //MARK: Get Horse list
    func getHorseList(completion:@escaping(Result<HorseListModel,Error>)->Void){
        provider.request(.gethorseList) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getEquipmentList(completion:@escaping(Result<EquipmetListModel,Error>)->Void){
        provider.request(.getEquipmentList) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getTackList(completion:@escaping(Result<TackListModel,Error>)->Void){
        provider.request(.getTackList) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //    MARK: Get All horse Categoty
    func getAllCategory(completion:@escaping(Result<HorseCategoryModel,Error>)->Void){
        provider.request(.getAllCategory) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getHorseDetails(params : [String:Any],completion:@escaping(Result<HorseDetailsModel,Error>)->Void){
        provider.request(.getHorseDetails(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getEquipmentDetails(params : [String:Any],completion:@escaping(Result<EquipmentDetailsModel,Error>)->Void){
        provider.request(.getEquipmentDetails(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getTackDetails(params : [String:Any],completion:@escaping(Result<TackDetailsModel,Error>)->Void){
        provider.request(.getTackDetails(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func addHorseList(params : [String:Any], completion:@escaping(Result<NewHorseListModel,Error>)->Void){
        provider.request(.addHorseList(params: params)) { (result) in
            switch result{
            case .success(let response):
                do{
                    let data = try JSONSerialization.jsonObject(with: response.data, options: [])
                    print("====>",data)
                }catch{
                    print("Error while decoding")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func deleteHorseList(params : [String:Any], completion:@escaping(Result<NewHorseListModel,Error>)->Void){
        provider.request(.horseDelete(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func updateHorseList(params : [String:Any], completion:@escaping(Result<NewHorseListModel,Error>)->Void){
        provider.request(.horseUpdate(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    func addEquipmentList(params : AddEquipmentDetails, completion:@escaping(Result<AddNewEquipmentListModel,Error>)->Void){
        provider.request(.addEquipmentList(params: params )) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    func addTackList(params : AddTackDetails, completion:@escaping(Result<NewTackListingModel,Error>)->Void){
        provider.request(.addTackList(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func updateProfile(params : UpdateProfile, completion:@escaping(Result<ProfileDetailModel,Error>)->Void){
        provider.request(.updateProfile(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getProfileList(completion:@escaping(Result<ProfileDataModel,Error>)->Void){
        provider.request(.getProfile) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getCommentList(params : Int,completion:@escaping(Result<GetCommentModel,Error>)->Void){
        provider.request(.getComment(postId: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    func getHorseParentList(params : [String : Any],completion:@escaping(Result<HorseParentDetailModel,Error>)->Void){
        provider.request(.getHorseParentsList(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func updateUserProfileImage(params : [String : Any], completion:@escaping(Result<NewTackListingModel,Error>)->Void){
        provider.request(.updateUserImage(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getHomeFeedPosts(params: [String : Any],completion:@escaping(Result<PostsModel,Error>)->Void) {
        provider.request(.getAllPost(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //horseFilter
    func getHorseFilterData(params: [String : Any],completion:@escaping(Result<HorseFilterModel,Error>)->Void) {
        provider.request(.horseFilter(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //equipmentFilter
    func getEquipmentFilterData(params: [String : Any],completion:@escaping(Result<EquipmentsFilterModel,Error>)->Void) {
        provider.request(.equipmentFilter(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //tackFilter
    func getTackFilterData(params: [String : Any],completion:@escaping(Result<TacksFilterModel,Error>)->Void) {
        provider.request(.tackfilter(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func createNewHomeFeedPost(params : CreatePostStruct,completion:@escaping(Result<CreatePostModel,Error>)->Void) {
        provider.request(.createPost(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    // get my profile
    func getMyProfile(completion:@escaping(Result<ProfileDetailModel,Error>)->Void) {
        provider.request(.getMyProfile) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    //get saved post
    func getSavedPost(completion:@escaping(Result<PostsModel,Error>)->Void) {
        provider.request(.getSavePost) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    // save like api
    func saveLikePost(params : [String:Any],completion:@escaping(Result<SaveLikeModel,Error>)->Void){
        provider.request(.saveLikePost(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    // post comment
    func commentPost(params : [String:Any],completion:@escaping(Result<CommentPostModel,Error>)->Void){
        provider.request(.commentPost(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getMarketplaceListings(completion:@escaping(Result<ListingsModel,Error>)->Void){
        provider.request(.getMarketplaceListings) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func changeMarketPlaceStatus(params : [String:Any],completion:@escaping(Result<ListingsModel,Error>)->Void){
        provider.request(.itemSelling(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    // save like api
    func saveMarketplaceListing(params : [String:Any],completion:@escaping(Result<SaveHorseTackEquipmentsModel,Error>)->Void){
        provider.request(.saveListing(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    //get saved listings
    func getSavedListings(completion:@escaping(Result<SavedListingsModel,Error>)->Void) {
        provider.request(.getSaveListing) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func changeProfilePassword(params : [String:Any],completion:@escaping(Result<ChangePasswordModel,Error>)->Void){
        provider.request(.changePass (params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    //MARK:- Forgot password.
    func reserPassword(params : [String:Any],completion:@escaping(Result<CheckEmailModel,Error>)->Void){
        provider.request(.resetPassword(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func verifyUser(params : [String:Any],completion:@escaping(Result<CheckEmailModel,Error>)->Void){
        provider.request(.verifyUser(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func shareCount(params : [String:Any],completion:@escaping(Result<CheckEmailModel,Error>)->Void){
        provider.request(.shareCount(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    
    func handleDecode<T>(result : Result<Moya.Response,MoyaError>,valueToDecode : @escaping (Result<T,Error>)->Void) where T: Codable {
        switch result {
        case .success(let response):
            do{
                print(try response.mapJSON())
                let json = try JSONDecoder().decode(T.self, from: response.data)
                switch response.statusCode {
                case 200...299:
                    valueToDecode(.success(json)).self
                    break
                case 300...599:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                default:
                    break
                }
            } catch {
                valueToDecode(.failure(error))
            }
        case .failure(let error):
            valueToDecode(.failure(error))
            break
        }
    }
    
    func handleError(data : ErrorModel?) -> MoyaError {
        let errror = NSError.init(domain: "com.remuda", code: 0, userInfo: [NSLocalizedDescriptionKey: data?.message ?? ""])
        let error = MoyaError.underlying(errror, nil)
        return error
    }
    
    
}
