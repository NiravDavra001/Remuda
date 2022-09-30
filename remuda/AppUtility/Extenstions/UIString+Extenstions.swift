//
//  UIString+Extenstions.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import Foundation
import UIKit

extension String {
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    /// Check mobile Validation
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    /// Check Password Validation
    public func validatePassword() -> Bool{
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: self)
    }
    /// Check Email Validation
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func firstLetterUppercased() -> String {
        guard let first = first, first.isLowercase else { return self }
        return String(first).uppercased() + dropFirst()
    }
    
    func timeInterval(timeAgo:String, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss", isSetTimezone: Bool = true) -> String
    {
        let df = DateFormatter()
        if  isSetTimezone{
            df.timeZone = TimeZone(abbreviation: "UTC")
        }
        df.dateFormat = dateFormat //"yyyy-MM-dd HH:mm:ss" || "yyyy-MM-dd'T'HH:mm:ss"
        let dateWithTime = df.date(from: timeAgo)
        if isSetTimezone{
            df.timeZone = TimeZone.current
        }
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime!, to: Date())
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"
            
        }
    }
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    func maximulNoOfLines(desLabel:UILabel)-> Int{
        let maxSize = CGSize(width: desLabel.frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: desLabel.font ?? UIFont()], context: nil).height
        let lineHeight = desLabel.font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? ""
    }
    
    func decodeUrl() -> String
    {
        return self.removingPercentEncoding ?? ""
    }
    
    mutating func insert(string:String,ind:Int) {
        self.insert(contentsOf: string, at:self.index(self.startIndex, offsetBy: ind) )
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
