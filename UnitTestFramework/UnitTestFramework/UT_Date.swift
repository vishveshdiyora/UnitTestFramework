//
//  UT_Date.swift
//  SimpleTest
//
//  Created by Vishvesh ibl@2019 on 12/06/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import Foundation

public class UT_Date{
    public class func isLeapYear(_ year: Int) -> Bool {
        let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
        return isLeapYear
    }

    public class func shortString(fromDate date: Date,format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
    
    public class func date(fromString dateString: String,format:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current
        return formatter.date(from: dateString)!
    }

    public class func isCurrentDate(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let today = shortString(fromDate:Date(),format:yourFormat)
        return today == dateString ? .success : .failure
    }

    public class func isPastDate(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let today = shortString(fromDate:Date(),format:yourFormat)
        return today > dateString ? .success : .failure
    }
    
    public class func isFutureDate(dateString: String,yourFormat:String) ->CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let today = shortString(fromDate:Date(),format:yourFormat)
        return today < dateString ? .success : .failure
    }
    
    public class func isWeekendDate(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let today = date(fromString: dateString,format:yourFormat)
        return today.isWeekend() ? .success : .failure
    }
    
    public class func isMonthValid(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = yourFormat
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        formatter1.locale = Locale.current
        
        guard let dateFromString = formatter1.date(from: dateString) else {
            return .failure
        }
         
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = formatter.string(from: dateFromString)
        if Int(month)! >= 1 && Int(month)! <= 12 {
            return .success
        }
        return .failure
    }
    
    public class func isDayValid(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = yourFormat
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        formatter1.locale = Locale.current
        
        guard let dateFromString = formatter1.date(from: dateString) else {
            return .failure
        }
         
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let day = formatter.string(from: dateFromString)
        if Int(day)! >= 1 && Int(day)! <= 31 {
            return .success
        }
        return .failure
    }
    
    public class func isDateValid(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = yourFormat
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        formatter1.locale = Locale.current
        
        guard formatter1.date(from: dateString) != nil else {
            return .failure
        }
        return .success
    }
    
    public class func isUSDate(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = yourFormat
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        formatter1.locale = Locale.current
        
        if formatter1.date(from: dateString) != nil {
            if yourFormat[0] == "M"{
                return .success
            }else{
                return .failure
            }
        }
        return .failure
    }
    
    public class func isUKDate(dateString: String,yourFormat:String) -> CaseResult {
        if dateString.isEmpty || dateString == ""{
            return .empty
        }
        let formatter1 = DateFormatter()
        formatter1.dateFormat = yourFormat
        formatter1.timeZone = TimeZone(secondsFromGMT: 0)
        formatter1.locale = Locale.current
        
        if formatter1.date(from: dateString) != nil {
            if yourFormat[0] == "d"{
                return .success
            }else{
                return .failure
            }
        }
        return .failure
    }
    
    public class func DateToAM_PM(dateString: String,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        let dt = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "hh:mm a"
        if dt != nil {
            let stringOfDate = dateFormatter.string(from: dt!)
            return stringOfDate
        } else {
            return ""
        }
    }
    
    public class func localToUTC(date: String,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if dt != nil {
            return dateFormatter.string(from: dt!)
        }
        return ""
    }
    
    
    public class func UTCToLocal(date: String ,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if dt != nil {
            return dateFormatter.string(from: dt!)
        }
        return ""
    }
    
    public class func daysInBetweenDate(_ date: Date) -> String {
        let diff = Calendar.current.dateComponents([.day], from: date, to: Date()).day!
        if Int(diff) >= 7 {
            return " \(Int((diff/7)))w"
        }
        return " \(Int(diff))d"
    }
    
    public class func getUTCFormateDate(_ localDate: Date) -> String {
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone! as TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: localDate)
        return dateString
    }
    
    public class func getAgeFromDateString(date: String ,format:String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        let dateOfBirth = dateFormater.date(from: date)
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from:
            dateOfBirth ?? Date(), to: Date())
        return (dateComponent.year ?? 0)
    }
    
    public class func currentDateWithFormat(format:String) -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateStr =  dateFormatter.string(from: currentDate)
        return dateStr
    }
    
    func convertDate(inputformat: String, outputformat: String, date: String,timeZone:TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputformat
        dateFormatter.calendar = NSCalendar.current
        let datee = dateFormatter.date(from: date)
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = outputformat
        return dateFormatter.string(from: datee!)
    }
}

