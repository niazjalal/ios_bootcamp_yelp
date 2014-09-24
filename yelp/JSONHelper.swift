//
//  JSONHelper.swift
//  yelp
//
//  Created by Niaz Jalal on 9/22/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import Foundation

class JSONHelper {
    
    class func JSONStringify(jsonObj: AnyObject) -> String {
        
        var e: NSError?
        
        let jsonData: NSData! = NSJSONSerialization.dataWithJSONObject(jsonObj, options: NSJSONWritingOptions(0), error: &e)
        if e != nil {
            return ""
        } else {
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding)
        }
    }
    
    class func JSONParseDict(jsonString:String) -> Dictionary<String, AnyObject> {
        
        var e: NSError?
        var data: NSData! = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonObj = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &e) as Dictionary<String, AnyObject>
        if e != nil {
            return Dictionary<String, AnyObject>()
        } else {
            return jsonObj
        }
    }
}