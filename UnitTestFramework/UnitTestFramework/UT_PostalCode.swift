//
//  UT_PostalCode.swift
//  SimpleTest
//
//  Created by Vishvesh ibl@2019 on 15/06/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import Foundation

public class UT_PostalCode{
    public class func isValidUSZipCode(code:String) -> CaseResult {
        if code.isEmpty || code == ""{
            return .empty
        }
        return NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-\\s]?\\d{4})?$")
        .evaluate(with: code.uppercased()) ? .success : .failure
    }
    
    public class func isContainsSpace(code:String) -> CaseResult {
        if code.isEmpty || code == ""{
            return .empty
        }
        if code.contains(" "){
            return .success
        }
        return .failure
    }
}
