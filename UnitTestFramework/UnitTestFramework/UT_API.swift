//
//  UT_API.swift
//  UnitTestFramework
//
//  Created by Vishvesh ibl@2019 on 15/06/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import Foundation

public enum APIMethod : String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public class UT_API {
    
    public class func apiCall(apiString:String,method:APIMethod,headers:[String:Any]?,parameters:[String:Any]?,completion: @escaping (_ success: Bool) -> ()) {

        var success = true
        
        let url = URL(string: apiString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        if headers != nil{
            for (key,value) in headers! {
                request.setValue(value as? String, forHTTPHeaderField: key)
            }
        }
        
        if parameters != nil{
            request.httpBody = parameters!.percentEncoded()
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                            // check for fundamental networking error
                print("error=\(error)")
                success = false
                print(success)
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = String(data: data, encoding: .utf8)
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: UInt(0))) as? [String: Any] {
                           print("json \(json)")
                    } else {
                        print("can not cast data")
                        success = false
                    }
                } catch let error {
                    print("cant parse json \(error)")
                    success = false
                    print(success)
                }
            completion(success)
        }
        task.resume()
     }
}

