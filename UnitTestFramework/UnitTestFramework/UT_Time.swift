//
//  UT_Time.swift
//  SimpleTest
//
//  Created by Vishvesh ibl@2019 on 12/06/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import Foundation

public class UT_Time{
    
    public class func isTimeValid(from string: String,format:String) -> CaseResult {
        if string.isEmpty || string == ""{
            return .empty
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        if (dateFormatter.date(from: string) != nil) {
            return .success
        }else{
            return .failure
        }
    }
    
    public class func isTime24(from string: String,format:String) -> CaseResult {
        if string.isEmpty || string == ""{
            return .empty
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        if (dateFormatter.date(from: string) != nil) {
            if format.contains("HH"){
                return .success
            }else{
                return .failure
            }
        }else{
            return .failure
        }
    }
    
    public class func isTime12(from string: String,format:String) -> CaseResult {
        if string.isEmpty || string == ""{
            return .empty
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        if (dateFormatter.date(from: string) != nil) {
            if format.contains("hh"){
                return .success
            }else{
                return .failure
            }
        }else{
            return .failure
        }
    }
}
