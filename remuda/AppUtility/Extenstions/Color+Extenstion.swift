//
//  Color+UIViewExtenstion.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: alpha)
    }
    
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
    
    
    static let app_green_color = UIColor(red: 19 / 255, green: 130 / 255, blue: 90 / 255, alpha: 1)
    
    static let button_border_color = UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1)
    static let buttonBackgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
    
    static let label_gray_color = UIColor(red: 127 / 255, green: 127 / 255, blue: 127 / 255, alpha: 1)
    static let label_gray_color_2 = UIColor(red: 61 / 255, green: 61 / 255, blue: 61 / 255, alpha: 1)
    static let label_statement_gray_color_3 = UIColor(red: 77 / 255, green: 77 / 255, blue: 77 / 255, alpha: 1)
    
    static let app_button_backgound_color = UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1)
    static let button_gray_color = UIColor(red: 104 / 255, green: 104 / 255, blue: 104 / 255, alpha: 1)
    
    static let segment_control_font_gray_color = UIColor(red: 191 / 255, green: 191 / 255, blue: 191 / 255, alpha: 1)
    static let search_bar_backgound_color = UIColor(red: 243 / 255, green: 243 / 255, blue: 243 / 255, alpha: 1)
    
    static let appFontPlaceholderColor = UIColor(red: 182 / 255, green: 182 / 255, blue: 182 / 255, alpha: 1)
    
    static let cell_tags_color = UIColor(red: 43 / 255, green: 93 / 255, blue: 223 / 255, alpha: 1)

    static let personalInformationBorder = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
    
    static let personalInformationTFlabel = UIColor(red: 0.602, green: 0.611, blue: 0.631, alpha: 1)
    
    static let app_segment_deSelectedText = UIColor(red: 0.748, green: 0.748, blue: 0.748, alpha: 1)
    static let label_bookmarks_postGrey_color = UIColor(red: 0.413, green: 0.413, blue: 0.413, alpha: 1)
    static let app_lblUserLocation = UIColor(red: 0.413, green: 0.413, blue: 0.413, alpha: 1)
    
    static let profile_listing_gray = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let profile_listing_topView_color = UIColor(red: 0.839, green: 0.635, blue: 0.112, alpha: 1).cgColor
    static let postLike_red_color = UIColor(red: 0.875, green: 0.082, blue: 0.227, alpha: 1)
    static let selectPhoto_background = UIColor(red: 0.955, green: 0.955, blue: 0.955, alpha: 1)
    
    static let newListingPostBorder = UIColor(red: 0.914, green: 0.918, blue: 0.927, alpha: 1)
    static let horseListing_border_gray = UIColor(red: 0.831, green: 0.839, blue: 0.855, alpha: 1)
    static let contactInfo_borderGray = UIColor(red: 0.831, green: 0.838, blue: 0.856, alpha: 1)
    static let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    static let filterGrey = UIColor(red: 0.6, green: 0.612, blue: 0.631, alpha: 1)
}
