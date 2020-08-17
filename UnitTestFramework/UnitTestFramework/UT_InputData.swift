//
//  UT_InputData.swift
//  SimpleTest
//
//  Created by Vishvesh ibl@2019 on 12/06/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import Foundation

public enum CaseResult{
    case success
    case failure
    case empty
}

public enum EquivalenceResult{
    case valid
    case invalid
}

public enum BoundaryResult{
    case lessThanRange
    case greaterThanRang
    case equalToMinimumValue
    case equalToMaximumValue
    case inBetweenRange
    case unknownValue
}

public class UT_InputData{
    
    public class func BoundaryCondition(value: Int, Range: ClosedRange<Int>) -> BoundaryResult{
        if Range.first == value{
            return .equalToMinimumValue
        }else if Range.last == value{
            return .equalToMaximumValue
        }else if Range.contains(value){
            return .inBetweenRange
        }else if value < Range.first!  {
            return .lessThanRange
        }else if  value > Range.last! {
            return .greaterThanRang
        }
        return .unknownValue
    }
    
    public class func EquivalenceClassPartitioning(value:Any,range:[Any]) -> EquivalenceResult {
        let a = "\(value)"
        var list : [String] = []
        range.forEach{ data in
            list.append("\(data)")
        }
        if list.contains(a) {
            return .valid
        }else{
            return .invalid
        }
    }
    
    public class func itHasGarbageValue(value:Any,expectedValue:Any) -> CaseResult {
        let a = "\(value)"
        let b = "\(expectedValue)"
        if a == b {
            return .failure
        }else{
            return .success
        }
    }
    
    public class func isMandatory(_ values: Any...) -> CaseResult {
        var flag = true
        for value in values {
            if let dict : [String:Any] = value as? [String : Any] {
                dict.forEach{a in
                    let b = "\(a.value)"
                    if b == "" || b == "[]"{
                       flag = false
                    }
                }
            }else{
                let a = "\(value)"
                if a == "" || a == "[]" || a == "0"{
                    flag = false
                }
            }
        }
        return flag ? .success : .failure
    }
    
    public class func itHasImprobableValue(value:Any,improbableValue:Any) -> CaseResult {
        let a = "\(value)"
        let b = "\(improbableValue)"
        if a == b {
            return .success
        }else{
            return .failure
        }
    }
    
    public class func isEmailValid(email:String) -> CaseResult{
        if email.isEmpty || email == ""{
            return .empty
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? .success : .failure
    }
    
    public class func isPasswordValid(password:String) -> CaseResult{
        if password.isEmpty || password == ""{
            return .empty
        }
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password) ? .success : .failure
    }
    
    public class func isValidUppercasePassword(testStr: String) -> CaseResult {
        if testStr.isEmpty || testStr == ""{
            return .empty
        }
        let psswordRegEx = "^(?=.*?[A-Z]).{1,}$"
        let psswordTest = NSPredicate(format: "SELF MATCHES %@", psswordRegEx)
        return psswordTest.evaluate(with: testStr) ? .success : .failure
    }

    public class func isValidLowercasePassword(testStr: String) -> CaseResult {
        if testStr.isEmpty || testStr == ""{
            return .empty
        }
        let psswordRegEx = "^(?=.*?[a-z]).{1,}$"
        let psswordTest = NSPredicate(format: "SELF MATCHES %@", psswordRegEx)
        return psswordTest.evaluate(with: testStr) ? .success : .failure
    }
    
    public class func isValidNumberPassword(testStr: String) -> CaseResult {
        if testStr.isEmpty || testStr == ""{
            return .empty
        }
        let psswordRegEx = "^(?=.*?[0-9]).{1,}$"
        let psswordTest = NSPredicate(format: "SELF MATCHES %@", psswordRegEx)
        return psswordTest.evaluate(with: testStr) ? .success : .failure
    }
    
    func isValidName(testStr: String) -> CaseResult {
        if testStr.isEmpty || testStr == ""{
            return .empty
        }
        let regex = "^([a-zA-Z '-])*$"
        let str = testStr.replacingOccurrences(of: "’", with: "'")
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: str, range: NSRange(str.startIndex..., in: str))
            let map = results.map {
                String(str[Range($0.range, in: str)!])
            }
            return map.count > 0 ? .success : .failure
        } catch _ {
            return .failure
        }
    }
    
    public class func isPhoneValid(phone:String) -> CaseResult{
        if phone.isEmpty || phone == ""{
            return .empty
        }
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: phone)
        return isValidPhone ? .success : .failure
    }
    
    public class func isNilOrEmpty(text:String) -> CaseResult {
        return text.isEmpty ? .success : .failure
    }
    
    public class func isLengthEqual(length: Int,text:String) -> CaseResult {
        return text.count == length ? .success : .failure
    }
    
    public class func isLengthGreaterThan(length: Int,text:String) -> CaseResult {
        return text.count > length ? .success : .failure
    }
    
    public class func isLengthLessThan(length: Int,text:String) -> CaseResult{
        return text.count < length ? .success : .failure
    }
    
    public class func isNegative(number: Int) -> CaseResult{
        return number < 0 ? .success : .failure
    }
    
    public class func isPositive(number: Int) -> CaseResult{
        return number > 0 ? .success : .failure
    }
    
    public class func isUnique(text: String) -> CaseResult{
        let size = text.count - 1
        for i in 0...size{
            let temp = text[i]
            let a = i + 1
            if a <= size{
                for j in a...size{
                    if temp == text[j]{
                        return .failure
                    }
                }
            }
        }
        return .success
    }
    
    public class func isOnlyLettersAllow(input:String) -> CaseResult{
        return input.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil ? .success : .failure
    }
    
    public class func isOnlyDigitsAllow(input:String) -> CaseResult{
        return input.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil ? .success : .failure
    }
    
    public class func isAllowOnlySpecificCharacters(input:String,allowableChar:String) -> CaseResult{
        return input.rangeOfCharacter(from: CharacterSet.init(charactersIn: allowableChar).inverted) == nil ? .success : .failure
    }
    
    public class func initialFirstCharecter(string: String) -> String {
        let trimmedString = string.trimmingCharacters(in: .whitespaces)
        var firstchar = "."
        if trimmedString != "" {
            firstchar = " " + ("\(String(describing: trimmedString.first!))")
            firstchar = (firstchar != " ") ? (firstchar + ".") : ""
        }
        return firstchar
    }
    
    public class func removeCharsOrSpecCharsFromString(text: String) -> String { // for only number
        let okayChars: Set<Character> =
            Set("0123456789")
        return String(text.filter {okayChars.contains($0) })
    }
    
    public class func removeSpecialCharsFromString(text: String) -> String { // for string
        let str = text.replacingOccurrences(of: "’", with: "'")
        let okayChars: Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- \'")
        return String(str.filter {okayChars.contains($0) })
    }
}



