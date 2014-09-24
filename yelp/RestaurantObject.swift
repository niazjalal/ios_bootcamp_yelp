//
//  RestaurantObject.swift
//  yelp
//
//  Created by Niaz Jalal on 9/23/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

class RestaurantObject: NSObject {
   
    var icon: String!
    var name: String!
    var distance: String!
    var rating: String!
    var reviews: String!
    var address: String!
    var categoryList: [String]! = []
    var categories: String!
    
    init(dictionary: NSDictionary) {
    
        icon = dictionary["image_url"] as? String
        name = dictionary["name"] as? String
        distance = dictionary["phone"] as? String
        rating = dictionary["rating_img_url"] as? String
        reviews = dictionary["review count"] as? String
        address = dictionary["display_address"] as? String
        
    }
    
    class func searchWithQuery(query: String, completion: ([RestaurantObject]!, NSError!) -> Void) {
        
        YelpClient.sharedInstance.searchWithTerm(query, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println(response)
            
            }) { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
            
            println(error)
        }
    }
}
