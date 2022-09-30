//
//  enums.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

enum FontName : String {
    case Bold                                                  = "OpenSans-Bold"
    case BoldItalic                                            = "OpenSans-BoldItalic"
    case ExtraBold                                             = "OpenSans-ExtraBold"
    case ExtraBoldItalic                                       = "OpenSans-ExtraBoldItalic"
    case Italic                                                = "OpenSans-Italic"
    case Light                                                 = "OpenSans-Light"
    case LightItalic                                           = "OpenSans-LightItalic"
    case Regular                                               = "OpenSans-Regular"
    case SemiBold                                              = "OpenSans-SemiBold"
    case SemiBoldItalic                                        = "OpenSans-SemiBoldItalic"
    
    case RBlack                                                = "Roboto-Black"
    case RBlackItalic                                          = "Roboto-BlackItalic"
    case RBold                                                 = "Roboto-Bold"
    case RBoldItalic                                           = "Roboto-BoldItalic"
    case RItalic                                               = "Roboto-Italic"
    case RLight                                                = "Roboto-Light"
    case RLightItalic                                          = "Roboto-LightItalic"
    case RMedium                                               = "Roboto-Medium"
    case RMediumItalic                                         = "Roboto-MediumItalic"
    case RRegular                                              = "Roboto-Regular"
    case RThin                                                 = "Roboto-Thin"
    case RThinItalic                                           = "Roboto-ThinItalic"
    
}

enum FontSize : CGFloat {
    case Size_10                                               = 10.0
    case Size_11                                               = 11.0
    case Size_12                                               = 12.0
    case Size_13                                               = 13.0
    case Size_14                                               = 14.0
    case Size_15                                               = 15.0
    case Size_16                                               = 16.0
    case Size_18                                               = 18.0
    case Size_20                                               = 20.0
    case Size_24                                               = 24.0
    case Size_28                                               = 28.0
    case Size_32                                               = 32.0
}

enum ViewControllerIdentifiers : String {
    ///  Login ViewControllers
    case  mainVC                                               = "ViewController"
    case  SignInVC                                             = "SignInViewController"
    case  CreateAccountVC                                      = "CreateAccountViewController"
    case  CreateAccountNameVC                                  = "CreateAccountNameViewController"
    case  CreateAccountProfilePhotoVC                          = "CreateAccountProfileViewController"
    case  CreateAccountPhoneVC                                 = "CreateAccountPhoneViewController"
    case  CreateAccountCityVC                                  = "CreateAccountCityViewController"
    case  ResetPasswordVC                                      = "ResetPasswordViewController"
    case  ConfirmationMailVC                                   = "ConfirmationMailViewController"
    case  CreateNewPasswordVC                                  = "CreateNewPasswordViewController"
    case  WebViewVC                                            = "WebViewViewController"
    ///    market Place View Controllers
    case  MarketPlacesHomeVC                                   = "MarketPlacesHomeViewController"
    case  HorseDetailsVC                                       = "HorseDetailsViewController"
    case  HorsesListVC                                         = "HorsesListViewController"
    case  EquipmentListingVC                                   = "EquipmentListingViewController"
    case  TackListingVC                                        = "TackListingViewController"
    
    case  UserListingsVC                                       = "UserListingsViewController"
    case  SellingListVC                                        = "SellingListViewController"
    case  ExpiredListVC                                        = "ExpiredListViewController"
    case  SoldListVC                                           = "SoldListViewController"
    
    case MarketPlaceFilterVC                                   = "MarketPlaceFilterViewController"
    case FilterVC                                              = "FilterViewController"
    case HorseFilterByLocationVC                               = "HorseFilterByLocationViewController"
    case FilterBySireVC                                        = "FilterBySireViewController"
    
    case MarketPlaceEquipmentFilterVC                          = "MarketPlaceEquipmentFilterViewController"
    case MarketPlaceTackFilterVC                               = "MarketPlaceTackFilterViewController"
    case TackTypeFilterVC                                      = "TackTypeFilterViewController"
    case HorseParentVC                                         = "HorseParentViewController"
    case HorseChildVC                                          = "HorseChildViewController"
    
    ///home View Controllers
    case HomeVC                                                = "HomeViewController"
    case CreateNewPostVC                                       = "CreateNewPostViewController"
    case SearchNewsFeedVC                                      = "SearchNewsFeedViewController"
    case FilterByLocationVC                                    = "FilterByLocationViewController"
    case SelectedHomePostVC                                    = "SelectedHomePostViewController"
    case TabBarController                                      = "TabBarController"
    
    ///profile View Controllers
    case ProfileVC                                             = "ProfileViewController"
    case ProfileInformationVC                                  = "ProfileInformationViewController"
    case BookmarksVC                                           = "BookmarksViewController"
    case PostsVC                                               = "PostsViewController"
    case ListingsVC                                            = "ListingsViewController"
    case SelectedPostVC                                        = "SelectedPostViewController"
    case supportVC                                             = "SupportViewController"
    case supportDetailVC                                       = "SupportDetailViewController"
    ///NewListing View Controllers
    case NewListingCategoryVC                                  = "NewListingCategoryViewController"
    case NewListingPaymentVC                                   = "NewListingPaymentViewController"
    case HorseListingVC                                        = "HorseListingViewController"
    case NewTackListingVC                                      = "NewTackListingViewController"
    case EquipmentVC                                           = "EquipmentViewController"
    case ContactInfoVC                                         = "ContactInfoViewController"
    case ContactInfoPopUPVC                                    = "ContactInfoPopUPViewController"
    case ChangePasswordVC                                      = "ChangePasswordViewController"
    case CreatePedigreeVC                                      = "CreatePedigreeViewController"
    case FillHorseDetailVC                                     = "FillHorseDetailViewController"
}

enum TableCellIdentifiers : String {
    ///cell identifiers
    case ProfileDetailTVCell                                   = "ProfileDetailTableViewCell"
    case PostsTVCell                                           = "PostsTableViewCell"
    case HorseImagesTitleTVCell                                = "HorseImagesTitleTableViewCell"
    case HorseOwnerDetailsTVCell                               = "HorseOwnerDetailsTableViewCell"
    case HorseDetailsTVCell                                    = "HorseDetailsTableViewCell"
    case SelectedPostTVCell                                    = "SelectedPostTableViewCell"
    case CommentTVCell                                         = "CommentTableViewCell"
    
    case PreviousLocationTVCell                                = "PreviousLocationTableViewCell"
    case SelectedHomePostTVCell                                = "SelectedHomePostTableViewCell"
    case HomePostCommentTVCell                                 = "HomePostCommentTableViewCell"
    case CommentReplyTVCell                                    = "CommentReplyTableViewCell"

    case ViewContactInfoTVCell                                 = "ViewContactInfoTableViewCell"

    ///header footer identifiers
    case ProfileHeader                                         = "ProfileHeader"
    case SignOutFooter                                         = "SignOutFooter"
    
    ///marketplace TableView Cell
    case MarketPlaceListingTVCell                              = "MarketPlaceListingTableViewCell"
    case FilterHorseTVCell                                     = "FilterHorseTableViewCell"
    case FilterCategoryTVCell                                  = "FilterCategoryTableViewCell"
    case PedigreeHorseDetailsTVCell                            = "PedigreeHorseDetailsTableViewCell"
    ///    home TableView Cell
    case HomePostsTVCell                                       = "HomePostsTableViewCell"
    /// NewListing Tableview Cell
    case CreatePadigreeMapTVCell                               = "CreatePadigreeMapTableViewCell"
    case NewListingCategoryTVCell                              = "NewListingCategoryTableViewCell"
    case supportListTVCell                                     = "SupportListTableViewCell"
}

enum CollectionCellIdentifiers : String {
    case ListingViewCVCell                                     = "ListingViewCollectionViewCell"
    case HorseDetailsCVCell                                    = "HorseDetailsCollectionViewCell"
    case HorseImagesCVCell                                     = "HorseImagesCollectionViewCell"
    ///NewListing CollectionView Identity
    case NewListingPhotosCVCell                                = "NewListingPhotosCollectionViewCell"
    case PhotoVideoSelectionCVCell                             = "PhotoVideoSelectionCollectionViewCell"
    ///Home Feed Image and video cell
    case HomeFeedImageVideoCVCell                              = "HomeFeedImageVideoCollectionViewCell"
    case PostGalleryCollectionViewCell                         = "PostGalleryCollectionViewCell"
}

enum ViewControllerTitle : String{
    ///   Login Title Identitty
    case signIn                                                = "Sign In"
    case createAccount                                         = "Create Account"
    case resetPassword                                         = "Reset Password"
    case createPassword                                        = "Create New Password"
    case yourProfile                                           = "Your Profile"
    case bookmarks                                             = "Bookmarks"
    case changePassword                                        = "Change Password"
    case personalInformation                                   = "Personal Information"
    case support                                               = "Support"
    ///    home Title Identity
    case home                                                  = "Home"
    case searchNewsFeed                                        = "Search News Feed"
    case filterByLocation                                      = "Filter by Location"
    
    ///NewListing Title Identity
    case yourHorseListing                                      = "Your Horse Listing"
    case blank                                                 = ""
    case YourTackListing                                       = "Your Tack Listing"
    case YourEquipmentListing                                  = "Your Equipment Listing"
    case YourContactInfo                                       = "Your Contact Info"
    case YourListings                                          = "Your Listings"
    ///marketplace
    case FilterHorses                                          = "Filter Horses"
    case FilterByDiscipline                                    = "Filter by Discipline"
    case FilterByBreed                                         = "Filter by Breed"
    case FilterByColor                                         = "Filter by Color"
    case FilterByGender                                        = "Filter by Gender"
    case FilterBySire                                          = "Filter by Sire"
    case FilterByFoalTo                                        = "Filter by Foal To"
    case FilterByLTE                                           = "Filter by LTE"
    case FilterByAge                                           = "Filter by Age"
    case FilterByHeight                                        = "Filter by Height"
    case FilterByPrice                                         = "Filter by Price"
    case TackFilter                                            = "Tack Filter"
    case EquipmentFilter                                       = "Equipment Filter"
    case FilterByType                                          = "Filter by Type"
    case FilterByCondition                                     = "Filter by Condition"
    case Pedigree                                              = "Pedigree"
}

enum StoryBoardIdentifiers : String {
    case  Main                                                 = "Main"
    case  MarketPlace                                          = "MarketPlace"
    case  Profile                                              = "Profile"
    case  Home                                                 = "Home"
    case  NewListing                                           = "NewListing"
}

enum localizedString : String {
    case enterName                                             = "enter_user_name"
    case enterPassword                                         = "enter_user_password"
    case validPassword                                         = "enter_valid_password"
    case enterOldPassword                                      = "enter_old_password"
    case enterNewPassword                                      = "enter_new_password"
    case enterConfirmPasswrod                                  = "enter_user_confirm_password"
    case enterMatchPassword                                    = "enter_match_password"
    case oldPasswordNewPassword                                = "old_password_new_password"
    case enterEmailPhone                                       = "enter_email_phone"
    case validEmail                                            = "valid_email"
    case validPhone                                            = "enter_your_valid_phone_number"
    case enterEmail                                            = "enter_email"
    case enterPhone                                            = "enter_phone"
    case enterAge                                              = "enter_age"
    case enterFirstName                                        = "enter_first_name"
    case enterSecondName                                       = "enter_second_name"
    case enterYourCity                                         = "enter_your_city"
    case enterYourPhoneNumber                                  = "enter_your_phone_number"

    ///added
    case enterTitle                                            = "enter_title"
    case enterPrice                                            = "enter_price"
    case eneterDescription                                     = "eneter_description"
    case enterHorseBreed                                       = "enter_horse_breed"
    case enterColor                                            = "enter_color"
    case enterApproximateHands                                 = "enter_approximate_height"
    case enterDiscipline                                       = "enter_discipline"
    case enterPedigree                                         = "enter_pedigree"
    case eneterLifeTimeEarning                                 = "enter_life_time_earning"
    case enterSignificantNameOnPapers                          = "enter_significant_name_on_papers"
    case enterAbilityLevel                                     = "enter_ability_level"
    case enterBreedingStock                                    = "enter_breeding_stock"
    case enterRadiographs                                      = "enter_radiographs"
    case enterBorndate                                         = "enter_borndate"
    case enterRegistrationNumber                               = "enter_registrationNumber"
    
    
    case enterEquipmentTitle                                   = "enter_equipment_title"
    case enterEquipmentPrice                                   = "enter_equipment_price"
    case enterEquipmentDescription                             = "enter_equipment_description"
    case enterEquipmentCondition                               = "enter_equipment_condition"
    
    case enterTackTitle                                        = "enter_tack_title"
    case enterTackPrice                                        = "enter_tack_price"
    case enterTackDescription                                  = "enter_tack_description"
    case enterTackType                                         = "enter_tack_type"
    case enterTackSaddles                                      = "enter_tack_saddles"
    case enterTackCondition                                    = "enter_tack_condition"
    case enterHoeseAge                                         = "enter_hoese_age"
    
    func getLocalizableString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

enum UserDefaultKeys : String {
    case isUserLogin                                                   = "isUserLogin"
    case appToken                                                      = "AppToken"
    case fbLoginID                                                     = "fbLoginID"
    case fbName                                                        = "fbName"
    case fbEmail                                                       = "fbEmail"
    case isFbLogin                                                     = "isFbLogin"
    case isVersionUpadted                                              = "isVersionUpdated"
}
enum UserDefaultModelKeys : String{
    case storeLoginModel                                               = "StoreLoginModel"
    case storeRegisterModel                                            = "StoreRegisterModel"
    case storeProfile                                                  = "StoreProfile"
    case storeAllHorseCategory                                         = "StoreAllHorseCategory"
    case storePreviousSearch                                           = "StorePreviousSearch"
    case storeDiscipline                                               = "StoreDiscipline"
    case storeBreed                                                    = "StoreBreed"
    case storeColor                                                    = "StoreColor"
    case storeGender                                                   = "StoreGender"
}

enum APIName : String {
    case register                                                      = "register"
    case login                                                         = "login"
    case emailExist                                                    = "emailExist"
    case gethorseList                                                  = "gethorseList"
    case getEquipmentList                                              = "getEquipmentList"
    case getTackList                                                   = "getTackList"
    case getHorseDetails                                               = "getHorseDetails"
    case getEquipmentDetails                                           = "getEquipmentDetails"
    case getTackDetails                                                = "getTackDetails"
}

var postData = [UserPostModel]()
enum FileType : Int{
    case image     = 0
    case video     = 1
}

enum FileExtType: String {
    case JPEG = "jpeg"
    case JPG = "jpg"
    case PNG  = "png"
    case BMP  = "bmp"
    case MP4   = "mp4"
    case MOV   = "MOV"
    case WMV   = "wmv"
    case AVI   = "avi"
    case AVCHD = "avchd"
    case FLV   = "flv"
    case F4V   = "f4v"
    case SWF   = "swf"
    case MKV   = "mkv"
    func returnFileType() -> Int {
        if self == .JPEG || self == .JPG || self == .PNG || self == .BMP{
            return FileType.image.rawValue
        }
        else{
            return FileType.video.rawValue
        }
    }
}
